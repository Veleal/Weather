
class LocationsInteractor {
    private let dataRepository: DataRepository!
    private let weatherRepository: WeatherRepository!
    
init(dataRepository: DataRepository, weatherRepository: WeatherRepository) {
        self.dataRepository = dataRepository
        self.weatherRepository = weatherRepository
    }
    
    func loadLocations(completion: ([Location]) -> Void) {
        let locations = dataRepository.getBookmarkedLocations()
        completion(locations)
    }
    
    func loadWeather(location: Location, completion: (Bool) -> Void) {
        weatherRepository.getWeather(location, completion:{(weather) in
            completion(weather != nil)
        })
    }
}
