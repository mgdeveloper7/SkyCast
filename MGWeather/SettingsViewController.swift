//
//  SettingsViewController.swift
//  MGWeather
//
//  Created by Mark Gumbs on 20/07/2016.
//  Copyright © 2016 britishairways. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate
{
//    func refreshData()
    func refreshWeatherDataFromService()
}

class SettingsViewController: UIViewController {

    var delegate:SettingsViewControllerDelegate?
    
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var okButton : UIButton!
    
    @IBOutlet weak var tempUnitsControl : UISegmentedControl!
    @IBOutlet weak var dayNightColourControl : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSettings()
        setupScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupScreen () {
    
        settingsView.backgroundColor = GlobalConstants.ViewShading.Lighter
        
        settingsView.alpha = 0.7

        // Make round corners for the outerviews
        settingsView.layer.cornerRadius = 10.0
        settingsView.clipsToBounds = true
    }
    
    
    // MARK:  Load/Save details
    func loadSettings() {
        
        let userDefaults = UserDefaults.standard
        var celsuisOrFahrenheit = userDefaults.string(forKey: GlobalConstants.Defaults.SavedTemperatureUnits)
        var dayOrNightColours = userDefaults.string(forKey: GlobalConstants.Defaults.SavedDayOrNightColourSetting)
        
        if (celsuisOrFahrenheit == nil) {
            celsuisOrFahrenheit = GlobalConstants.DefaultTemperatureUnit  // Celsius
            saveSettings()
        }
        else {
            if celsuisOrFahrenheit == GlobalConstants.TemperatureUnits.Celsuis {
                tempUnitsControl.selectedSegmentIndex = 0
            }
            else {
                tempUnitsControl.selectedSegmentIndex = 1
            }
        }
        
        if (dayOrNightColours == nil) {
            dayOrNightColours = GlobalConstants.DefaultDayOrNightSwitch  // On
            saveSettings()
        }
        else {
            if dayOrNightColours == "ON" {
                dayNightColourControl.selectedSegmentIndex = 0
            }
            else {
                dayNightColourControl.selectedSegmentIndex = 1
            }
        }

    }
    
    func saveSettings() {
        
        // Save any settings to NSUserDefaults
        var celsuisOrFahrenheit : String!
        var dayOrNightColours : String!
        
        if (tempUnitsControl.selectedSegmentIndex == 0) {
            celsuisOrFahrenheit = GlobalConstants.TemperatureUnits.Celsuis
        }
        else {
            celsuisOrFahrenheit = GlobalConstants.TemperatureUnits.Fahrenheit
        }

        if (dayNightColourControl.selectedSegmentIndex == 0) {
            dayOrNightColours = "ON"
        }
        else {
            dayOrNightColours = "OFF"
        }

        let userDefaults = UserDefaults.standard
        userDefaults.set(celsuisOrFahrenheit, forKey: GlobalConstants.Defaults.SavedTemperatureUnits)
        userDefaults.set(dayOrNightColours, forKey: GlobalConstants.Defaults.SavedDayOrNightColourSetting)
        
       //self.delegate?.refreshData()
        self.delegate?.refreshWeatherDataFromService()
    }
    
    
    // MARK:  Button Methods
    @IBAction func okButtonPressed(_ sender: AnyObject) {
        
        saveSettings()
        
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

}
