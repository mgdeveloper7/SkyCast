//
//  Utility.swift
//  MGWeather
//
//  Created by Mark Gumbs on 02/09/2016.
//  Copyright © 2016 britishairways. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func getWeatherIcon(serviceIcon : String) -> String {
        
        var iconName : String!
        
        switch serviceIcon {
        case "clear-day":
            iconName = GlobalConstants.WeatherIcon.clearDay
        case "clear-night" :
            iconName = GlobalConstants.WeatherIcon.clearNight
        case "rain" :
            iconName = GlobalConstants.WeatherIcon.rain
        case "snow":
            iconName = GlobalConstants.WeatherIcon.snow
        case "sleet":
            iconName = GlobalConstants.WeatherIcon.sleet
        case "wind":
            iconName = GlobalConstants.WeatherIcon.wind
        case "fog":
            iconName = GlobalConstants.WeatherIcon.fog
        case "cloudy":
            iconName = GlobalConstants.WeatherIcon.cloudy
        case "partly-cloudy-day":
            iconName = GlobalConstants.WeatherIcon.partlyCloudyDay
        case "partly-cloudy-night":
            iconName = GlobalConstants.WeatherIcon.partlyCloudyNight
        default:
            iconName = ""
        }
        
        return iconName
    }
    
    class func getWeatherImage(serviceIcon : String) -> String {
        
        var imageName : String!
        
        switch serviceIcon {
        case "clear-day":
            imageName  = GlobalConstants.ImageFile.FileName.clearDay.rawValue
        case "clear-night" :
            imageName  = GlobalConstants.ImageFile.FileName.clearNight.rawValue
        case "rain" :
            imageName  = GlobalConstants.ImageFile.FileName.rain.rawValue
        case "snow":
            imageName  = GlobalConstants.ImageFile.FileName.snow.rawValue
        case "sleet":
            imageName  = GlobalConstants.ImageFile.FileName.sleet.rawValue
        case "wind":
            imageName  = GlobalConstants.ImageFile.FileName.wind.rawValue
        case "fog":
            imageName  = GlobalConstants.ImageFile.FileName.fog.rawValue
        case "cloudy":
            imageName  = GlobalConstants.ImageFile.FileName.cloudy.rawValue
        case "partly-cloudy-day":
            imageName  = GlobalConstants.ImageFile.FileName.partlyCloudyDay.rawValue
        case "partly-cloudy-night":
            imageName = GlobalConstants.ImageFile.FileName.partlyCloudyNight.rawValue
        default:
            imageName  = ""
        }
        
        return imageName
    }
}
