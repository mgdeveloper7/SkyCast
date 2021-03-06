//
//  TodayTabVC.swift
//  Weather
//
//  Created by Mark Gumbs on 28/06/2016.
//  Copyright © 2016 britishairways. All rights reserved.
//

import UIKit

protocol TodayTabVCDelegate
{
    func refreshWeatherDataFromService()
    func refreshWeatherDataFromService2(completionHandler: @escaping GlobalConstants.CompletionHandlerType)
}

class TodayTabVC: UIViewController, UITextViewDelegate {
    
    var delegate:TodayTabVCDelegate?
    var dayOrNightColourSetting: String?
    
    // MARK: Outlets
    
    @IBOutlet weak var outerScreenView : UIView!
    
    @IBOutlet weak var weatherLabel : UILabel!
    @IBOutlet weak var weatherImage : UIImageView!
    @IBOutlet weak var lastUpdatedLabel : UILabel!

    @IBOutlet weak var currentTempView : UIView!
    @IBOutlet weak var currentTemp : UILabel!
    @IBOutlet weak var windspeed : UILabel!
    @IBOutlet weak var feelsLikeTemp : UILabel!
    @IBOutlet weak var currentWeatherIcon : UIImageView!

    @IBOutlet weak var currentSummary : UILabel!

    @IBOutlet weak var weatherDetailView : UIView!
    @IBOutlet weak var todayHighLowTemp : UILabel!
    @IBOutlet weak var cloudCover : UILabel!
    @IBOutlet weak var rainProbability : UILabel!
    
    @IBOutlet weak var sunriseStackView : UIStackView!
    @IBOutlet weak var sunrise : UILabel!
    @IBOutlet weak var sunset : UILabel!
    @IBOutlet weak var humidity : UILabel!
    @IBOutlet weak var weatherAlertButton : UIButton!
    @IBOutlet weak var poweredByDarkSkyText : UITextView!
    
    private let cellId = "cellId"
    
//    @IBOutlet weak var weatherCreditLabel : UITextView!
    
    @IBOutlet weak var hourlyWeatherTableView : UITableView!
    @IBOutlet weak var hourlyWeatherTableViewHeight : NSLayoutConstraint!
    
    @IBOutlet weak var dailyWeather : Weather!
    
    enum Menu: String {
        case ShowSettings = "App Settings"
        case ShowAbout = "About"
    }
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupSwipeGestures()
        
        initialScreenSetup ()
        
        populateTodayWeatherDetails()
        

        // Rotate 90 degrees

        // hourlyWeatherTableView.transform =  CGAffineTransformMakeRotation(CGFloat(-M_PI/2))
        // hourlyWeatherTableView.frame = CGRectMake(0, view.bounds.height/8, view.bounds.width, view.bounds.height)

        //hourlyWeatherTableViewHeight.constant = self.view.frame.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createHorizontalTableView() {
        
        let frame = CGRect(x: 0, y: view.bounds.height/8, width: view.bounds.width/6, height: view.bounds.height/8)
        
        tableView = UITableView(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        
        if tableView.responds(to: (#selector(getter: UITableViewCell.separatorInset))) {
            tableView.separatorInset = UIEdgeInsets.zero;
        }
        
        if tableView.responds(to:(#selector(getter: UIView.layoutMargins))) {
            tableView.layoutMargins = UIEdgeInsets.zero;
        }
        
        tableView.transform = CGAffineTransform(rotationAngle: -CGFloat(M_PI_2))

        view.addSubview(tableView)
}
    
    
    func initialScreenSetup () {
                      
        // Make the credit label clickable
        let urlString = "Powered By Dark Sky API"
        let attributedString = NSMutableAttributedString(string: urlString)
        attributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.DarkSkyURL, range: NSRange(location: 0, length: 23))
        
//        attributedString.addAttribute(NSFontAttributeName,
//                                     value: UIFont(
//                                        name: "HelveticaNeue-UltraLight",
//                                        size: 10.0),
//                                     range: NSRange(
//                                        location: 0,
//                                        length:23))
        
        poweredByDarkSkyText.attributedText = attributedString

        currentTempView.backgroundColor = GlobalConstants.ViewShading.Lighter
        weatherDetailView.backgroundColor = GlobalConstants.ViewShading.Darker
        sunriseStackView.backgroundColor = GlobalConstants.TableViewAlternateShadingDay.Darker
    }
    

    // MARK:  Swipe Gesture functions
    
    func setupSwipeGestures () {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(TodayTabVC.swiped(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(TodayTabVC.swiped(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(TodayTabVC.swiped(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(TodayTabVC.swiped(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func swiped(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
                
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped Right")
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped Left")
                
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped Up")
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped Down")
                
                refreshWeatherDataFromService()
            default:
                break
            }
        }
    }
    
    func refreshWeatherDataFromService() {
        
        // Make a toast to say data is refreshing
        self.view.makeToast("Refreshing weather data", duration: 1.0, position: .bottom)
        self.view.makeToastActivity(.center)
        
        self.delegate?.refreshWeatherDataFromService2
            { (result) -> Void in
                switch (result) {
                    
                // A refreshed weather object is returned, pass this back into dailyWeather
                case .Success(let refreshedWeatherData):
                    
                    self.dailyWeather = refreshedWeatherData as! Weather
                    
                    // Refresh the screen and table view
                    DispatchQueue.main.async {

                        self.populateTodayWeatherDetails()
                        self.hourlyWeatherTableView.reloadData()
                        self.view.hideToastActivity()
                        
                        // Scroll to the top of the icon list
                        self.hourlyWeatherTableView.contentOffset = CGPoint(x: 0, y: 0 - self.hourlyWeatherTableView.contentInset.top)
                    }
                    
                    break;
                case .Failure(let error):
                    // Make a toast to say data is refreshing
                    self.view.makeToast("Error retrieving weather data", duration: 3.0, position: .bottom)
                    
                    print("\(error)")
                    break;
                }
        }

    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        UIApplication.shared.openURL(URL as URL)
        return false
    }
    
    func populateTodayWeatherDetails() {

        // Rather than force unwrapping, use conditional let
        if let todayArray = dailyWeather?.currentBreakdown {
            
            let today = NSDate()
            let timeNow = today.shortTimeString()
            
            lastUpdatedLabel.text = "Last Updated: " + timeNow

            // NOTE:  Better to use the Minute summary at this level

            currentTemp.text = String(Int(round(todayArray.temperature! as Float))) + GlobalConstants.degreesSymbol
            feelsLikeTemp.text = "Feels Like: " + String(Int(round(todayArray.apparentTemperature! as Float))) + GlobalConstants.degreesSymbol
            windspeed.text = String(Int(round(todayArray.windSpeed! * GlobalConstants.MetersPerSecondToMph))) + " mph"
            rainProbability.text = String(Int(round(todayArray.precipProbability!*100))) + "%"
            cloudCover.text = String(Int(round(todayArray.cloudCover!*100))) + "%"
            humidity.text = String(Int(round(todayArray.humidity!*100))) + "%"

            
            // Min Temp, Max Temp, Sunrise and Sunset we can get from the 'daily' figures
            
            let dayArray = dailyWeather?.dailyBreakdown.dailyStats
            
            for days in dayArray! {
                
                // If today, populate the relevant fields
                let sameDay = areDatesSameDay(date1: todayArray.dateAndTimeStamp!, date2: days.dateAndTimeStamp!)
                
                if sameDay {
                    let minTempString = String(Int(round(days.temperatureMin!))) + GlobalConstants.degreesSymbol
                    let maxTempString = String(Int(round(days.temperatureMax!))) + GlobalConstants.degreesSymbol
                    
                    sunrise.text = String(days.sunriseTimeStamp!.shortTimeString())
                    sunset.text = String(days.sunsetTimeStamp!.shortTimeString())
                    
                    todayHighLowTemp.text = maxTempString + " / " + minTempString
                }
            }
            
            let minuteBreakdown = dailyWeather?.minuteBreakdown
            if todayArray.icon == "rain" {
                // Find out how much rain we have
                
                //let rainIntensity = getRainIntensity(rainIntensity: todayArray.precipIntensity!)
                //currentSummary.text = (minuteBreakdown?.summary)! + " (" + rainIntensity + ")"
                currentSummary.text = (minuteBreakdown?.summary)!
            }
            else {
                currentSummary.text = minuteBreakdown?.summary
            }
            
            // TODO:  Loop through 'minutely'.  See if we can find rain within the next hour
            
//            let minuteArray = dailyWeather?.minuteBreakdown.minuteStats
//            var minuteCount = 0
//            
//            minuteLoop: for minute in minuteArray! {
//                
//                // Get the WeatherStats from withing the minute breakdown
//                
//                minuteCount += 1
//                if minute.precipType == "rain" {
//                    break minuteLoop
//                }
//                
//            }

           // if minuteCount < 60 {
           //     currentSummary.text = currentSummary.text! + ". Rain due in the next " + String(minuteCount) + " minutes"
           // }
            
            // Populate the weather image
            let icon = todayArray.icon
            let enumVal = GlobalConstants.Images.ServiceIcon(rawValue: icon!)
            let iconName = Utility.getWeatherImage(serviceIcon: (enumVal?.rawValue)!)
            
            if String(iconName).isEmpty != nil {
                weatherImage.image = UIImage(named: iconName)!
            }

            // Populate the weather icon
            
            let weatherIconEnumVal = GlobalConstants.Images.ServiceIcon(rawValue: icon!)
            let weatherIconName = Utility.getWeatherIcon(serviceIcon: (weatherIconEnumVal?.rawValue)!)
            if String(weatherIconName).isEmpty != nil {
                currentWeatherIcon.image = UIImage(named: weatherIconName)!
            }

            // If weather alert, enable the button so user can bring up alert text view
            if (dailyWeather?.weatherAlert == true) {
                weatherAlertButton.isEnabled = true
                weatherAlertButton.setTitle("YES", for: .normal)
            }
            else {
                weatherAlertButton.isEnabled = false
                weatherAlertButton.setTitle("NO", for: .normal)
            }
        }

        UIView.animate(withDuration: 0.7, delay: 0.7, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.outerScreenView.alpha = 1.0

            }, completion:{_ in
                //self.refreshingTest.hidden = true
        })
        
    }
    
    func areDatesSameDay (date1: NSDate, date2: NSDate) -> Bool {
        
        var retVal = false
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"  // Remove timestamp for comparison
        
        let compareDateString1 = df.string(from: date1 as Date)
        let compareDateString2 = df.string(from: date2 as Date)
        
        if compareDateString1 == compareDateString2 {
            retVal = true
        }
        
        return retVal
    }
    
//    func getRainIntensity (rainIntensity : Float) -> String {
//        
//        // Decode how much rain we will have
//        
//        var retVal = ""
//        
//        switch rainIntensity {
//        case 0...0.0019: retVal = "No rain"
//        case 0.002...0.0169: retVal = "Very light rain"
//        case 0.017...0.099: retVal = "Light rain"
//        case 0.1...0.399: retVal = "Moderate rain"
//        case 0.4...100.00: retVal = "Heavy rain"
//        default: print("No rain")
//        }
//        
//        return retVal
//    }
    
    
//    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
//        
//        print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
//
//    }
//
//    // Obtain the distance between two points on Longitude/Latitude
//
//    func getDistanceBetween (location1: CLLocation, location2: CLLocation, units: String) -> Float {
//        
//        let distanceInMeters = location1.distanceFromLocation(location2)
//        
//        var retVal : Float
//        
//        switch units {
//        case "M" :
//            retVal = Float(distanceInMeters)
//        case "K" :
//            retVal = Float(distanceInMeters / 1000)
//        case "MI" :
//            retVal = Float(distanceInMeters / 1609)
//        default:
//            retVal = 0.0
//        }
//        
//        return retVal
//    }
    
}

// MARK:- Extension:  UIPopoverPresentationControllerDelegate methods

extension TodayTabVC : UIPopoverPresentationControllerDelegate {
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationController(popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverToRect rect: UnsafeMutablePointer<CGRect>, inView view: AutoreleasingUnsafeMutablePointer<UIView?>) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}


// MARK: UITableViewDataSource
extension TodayTabVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GlobalConstants.NumberOfHoursToShowFromNow
    }
    
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let userDefaults = UserDefaults.standard
            dayOrNightColourSetting = userDefaults.string(forKey: GlobalConstants.Defaults.SavedDayOrNightColourSetting)
            
            if (dayOrNightColourSetting == nil) {
                dayOrNightColourSetting = GlobalConstants.DefaultDayOrNightSwitch  // ON
            }
        }
        
        // We dont want the current hour in this list so +1
        let hourWeather = dailyWeather?.hourBreakdown.hourStats[indexPath.row + 1]
        
        let cell:HourlyWeatherCell = self.hourlyWeatherTableView.dequeueReusableCell(withIdentifier: "HourWeatherCellID") as! HourlyWeatherCell
        
        cell.hourLabel.text = hourWeather?.dateAndTimeStamp!.shortHourTimeString()
        cell.temperatureLabel.text = String(Int(round(hourWeather!.temperature!))) + GlobalConstants.degreesSymbol
        
        let icon = hourWeather?.icon
        let iconName = Utility.getWeatherIcon(serviceIcon: icon!)
        
        if iconName != "" {
            cell.summaryIcon.image = UIImage(named: iconName)!
        }
        
        // Alternate the shading of each table view cell

        if dayOrNightColourSetting == "ON" {
            if (indexPath.row % 2 == 0) {
                // Lighter Shade
                
                if hourWeather?.dayOrNight == "DAY" {
                    cell.backgroundColor = GlobalConstants.TableViewAlternateShadingDay.Darker
                }
                else {
                    cell.backgroundColor = GlobalConstants.TableViewAlternateShadingNight.Darker
                }
            }
            else {
                if hourWeather?.dayOrNight == "DAY" {
                    cell.backgroundColor = GlobalConstants.TableViewAlternateShadingDay.Lighter
                }
                else {
                    cell.backgroundColor = GlobalConstants.TableViewAlternateShadingNight.Lighter
                }
            }
        }
        else {
            if (indexPath.row % 2 == 0) {
                // Lighter Shade
                cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Darker
            }
            else {
                cell.backgroundColor = GlobalConstants.TableViewAlternateShading.Lighter
            }
        }

        return cell
    }
}


// MARK: UITableViewDelegate
extension TodayTabVC : UITableViewDelegate {

    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

// MARK:- Extension:  SettingsViewControllerDelegate

extension TodayTabVC : SettingsViewControllerDelegate {
    
    // Refresh data after pressing 'OK' in the settings screen
    func refreshData() {
        print("Refreshing data")
        self.refreshWeatherDataFromService()
    }
}


