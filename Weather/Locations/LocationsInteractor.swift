
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
    
    func deleteLocations(locationId: String, completion: ([Location]) -> Void) {
          let locations = dataRepository.deleteLocation(locationId)
          completion(locations)
      }
      
    
    func loadWeather(location: Location, completion: @escaping (Bool) -> Void) {
        weatherRepository.getWeather(location, completion:{(stationInfo) in
            location.stationInfo = stationInfo
            completion(stationInfo != nil)
        })
    }
}
