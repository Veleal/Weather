protocol WeatherRepository {
    func getWeather(_ location: Location, completion: (Weather?) -> Void)
}
