
import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var weatherConditionLbl: UILabel!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var cloudCoverageLbl: UILabel!  
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windspeedLbl: UILabel!
    @IBOutlet weak var avtivityView: UIView!
    
    func setCell(location: Location) {
        guard let stationInfo = location.stationInfo else {return}
        avtivityView.isHidden = true;
        
        weatherConditionLbl.text = Condition.weatherSymbol(fromWeatherCode: stationInfo.weather.first?.id)
        cityNameLbl.text = stationInfo.name
        temperatureLbl.text = stationInfo.main.temp.string
        cloudCoverageLbl.text = stationInfo.clouds.all.string+"%"
        humidityLbl.text = stationInfo.main.humidity.string+"%"
        windspeedLbl.text = stationInfo.wind.speed.string

    }
}
