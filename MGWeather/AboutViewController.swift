//
//  AboutViewController.swift
//  MGWeather
//
//  Created by Mark Gumbs on 20/07/2016.
//  Copyright © 2016 britishairways. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var aboutVersion: UILabel!
    @IBOutlet weak var aboutAuthor: UILabel!
    @IBOutlet weak var aboutDescription: UILabel!

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLink: UITextView!
    
    @IBOutlet weak var creditsView: UIView!
    @IBOutlet weak var weatherSource: UITextView!
    @IBOutlet weak var iconSource: UITextView!
    @IBOutlet weak var photoSource: UITextView!
    
    @IBOutlet weak var aboutCredits: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScreen () {
    
        emailView.backgroundColor = GlobalConstants.ViewShading.Lighter
        creditsView.backgroundColor = GlobalConstants.ViewShading.Lighter
        
        emailLink.backgroundColor = GlobalConstants.ViewShading.Darker
        weatherSource.backgroundColor = GlobalConstants.ViewShading.Darker
        iconSource.backgroundColor = GlobalConstants.ViewShading.Darker
        photoSource.backgroundColor = GlobalConstants.ViewShading.Darker

        // Make round corners for the outerviews
        emailView.layer.cornerRadius = 10.0
        emailView.clipsToBounds = true
        
        creditsView.layer.cornerRadius = 10.0
        creditsView.clipsToBounds = true
        
        // Make corners for the textviews, for effect
        emailLink.layer.cornerRadius = 10.0
        emailLink.clipsToBounds = true
        
        weatherSource.layer.cornerRadius = 10.0
        weatherSource.clipsToBounds = true
        
        iconSource.layer.cornerRadius = 10.0
        iconSource.clipsToBounds = true
        
        photoSource.layer.cornerRadius = 10.0
        photoSource.clipsToBounds = true
        
        let emailString = GlobalConstants.SupportEmailAddress
        let emailAttributedString = NSMutableAttributedString(string: emailString)
        emailAttributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.SupportEmailAddress, range: NSRange(location: 0, length: emailString.characters.count))
        emailLink.attributedText = emailAttributedString

        // Make the label to the credits clickable
        let urlString = "Weather API powered By Dark Sky API"
        let attributedString = NSMutableAttributedString(string: urlString)
        attributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.DarkSkyURL, range: NSRange(location: 0, length: urlString.characters.count))
        weatherSource.attributedText = attributedString

        let iconUrlString = "Weather icons from Icons8"
        let iconAttributedString = NSMutableAttributedString(string: iconUrlString)
        iconAttributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.WeatherIconURL, range: NSRange(location: 0, length: iconUrlString.characters.count))
        iconSource.attributedText = iconAttributedString

        let photosUrlString = "Weather photos from FreeDigitalPhotos"
        let photosAttributedString = NSMutableAttributedString(string: photosUrlString)
        photosAttributedString.addAttribute(NSLinkAttributeName, value: GlobalConstants.WeatherPhotosURL, range: NSRange(location: 0, length: photosUrlString.characters.count))
        photoSource.attributedText = photosAttributedString

        let deviceHardware = UIDeviceHardware.platformString()
       
        let majorVersion = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
        let minorVersion = ProcessInfo.processInfo.operatingSystemVersion.minorVersion
        
        let iosVersion = String(majorVersion) + "." + String(minorVersion)
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
 
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }

}
