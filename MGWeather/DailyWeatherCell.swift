//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Mark Gumbs on 30/06/2016.
//  Copyright © 2016 britishairways. All rights reserved.
//

import UIKit

class DailyWeatherCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var dateLabel : UILabel!
//    @IBOutlet weak var dateSuffixLabel : UILabel!
    @IBOutlet weak var sunriseIcon : UIImageView!
    @IBOutlet weak var sunriseLabel : UILabel!
    @IBOutlet weak var sunsetIcon : UIImageView!
    @IBOutlet weak var sunsetLabel : UILabel!
    @IBOutlet weak var dayDurationLabel : UILabel!
    @IBOutlet weak var dailyWeatherIcon : UIImageView!
    @IBOutlet weak var summaryLabel : UILabel!
    @IBOutlet weak var minTempLabel : UILabel!
    @IBOutlet weak var maxTempLabel : UILabel!
    @IBOutlet weak var rainProbabilityLabel : UILabel!
    
}
