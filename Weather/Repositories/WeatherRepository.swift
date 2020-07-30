protocol WeatherRepository {
    func getWeather(_ location: Location, completion: @escaping (StationInfo?) -> Void)
}
