//
//  Weather.swift
//  Weather
//
//  Created by Mark Gumbs on 25/06/2016.
//  Copyright © 2016 britishairways. All rights reserved.
//

import UIKit

class Weather: NSObject {

    var latitude : Float?
    var longitude : Float?
    var timezone : String?
    var offset : Int?
    var weatherAlert = false
    var currentBreakdown = WeatherStats()
    var minuteBreakdown = MinuteBreakdown()
    var hourBreakdown = HourBreakdown()
    var dailyBreakdown = DailyBreakdown()
    var weatherAlerts = [WeatherAlerts]()
    
    override init(){
        
    }
    
    init(fromDictionary weatherDict: NSDictionary){
        
        if let lLatitude  = weatherDict["latitude"] as? Float {
            latitude = lLatitude
        }

        if let lLongitude  = weatherDict["longitude"] as? Float {
            longitude = lLongitude
        }
        
        if let lTimezone = weatherDict["timezone"] as? String {
            timezone = lTimezone
        }
        
        if let lOffset  = weatherDict["offset"] as? Int {
            offset = lOffset
        }
        
        if let lCurrentBreakdown = weatherDict["currently"] as? NSDictionary {
            print("..currentBreakdown dict")
            
            currentBreakdown = WeatherStats(fromDictionary: lCurrentBreakdown )
        }
        
        if let lMinuteBreakdown = weatherDict["minutely"] as? NSDictionary {
            print("..minuteBreakdown dict")
            
            //minuteBreakdown = lMinuteBreakdown.flatMap({ MinuteBreakdown(fromDictionary: $0) })
            minuteBreakdown = MinuteBreakdown(fromDictionary: lMinuteBreakdown )
        }

        if let lHourBreakdown = weatherDict["hourly"] as? NSDictionary {
            print("..hourBreakdown dict")
            
            //hourBreakdown = lHourBreakdown.flatMap({ HourBreakdown(fromDictionary: $0) })
            hourBreakdown = HourBreakdown(fromDictionary: lHourBreakdown )
        }

        if let lDailyBreakdown = weatherDict["daily"] as? NSDictionary {
            print("..dailyBreakdown dict")
            
            //dailyBreakdown = lDailyBreakdown.flatMap({ DailyBreakdown(fromDictionary: $0) })
            dailyBreakdown = DailyBreakdown(fromDictionary: lDailyBreakdown )

        }
    
        if let lWeatherAlerts = weatherDict["alerts"] as? [NSDictionary] {
            print("..weatherAlerts dict")
            
            weatherAlert = true
            weatherAlerts = lWeatherAlerts.flatMap({ WeatherAlerts(fromDictionary: $0) })

        }

    }

}
