//
//  WeatherDetailVC.swift
//  Weather
//
//  Created by Illya Kuznietsov on 30.07.2020.
//  Copyright © 2020 _. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {
    @IBOutlet weak var weatherConditionLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var temperatureMinLbl: UILabel!
    @IBOutlet weak var temperatureMaxLbl: UILabel!
    @IBOutlet weak var preasureLbl: UILabel!
    @IBOutlet weak var cloudCoverageLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windspeedLbl: UILabel!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    
    var stationInfo: StationInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stationInfo = stationInfo else {return}
        weatherConditionLbl.text = Condition.weatherSymbol(fromWeatherCode: stationInfo.weather.first?.id)
        cityNameLbl.text = stationInfo.name
        temperatureLbl.text = stationInfo.main.temp.string
        temperatureMinLbl.text = stationInfo.main.temp_min.string
        temperatureMaxLbl.text = stationInfo.main.temp_max.string
        preasureLbl.text = stationInfo.main.pressure.string
        cloudCoverageLbl.text = stationInfo.clouds.all.string+"%"
        humidityLbl.text = stationInfo.main.humidity.string+"%"
        windspeedLbl.text = stationInfo.wind.speed.string
        sunriseLbl.text = DateManager.getStringDate(timestamp: stationInfo.sys.sunrise, timeZone: stationInfo.timezone)
        sunsetLbl.text = DateManager.getStringDate(timestamp: stationInfo.sys.sunset, timeZone: stationInfo.timezone)
    }
}
