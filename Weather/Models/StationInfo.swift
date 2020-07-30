
struct StationInfo: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Cloud
    let name: String
    let sys: Sys
    let timezone: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String  
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Cloud: Codable {
    let all: Int
}

struct Sys: Codable {
    let sunrise: UInt32
    let sunset: UInt32
}
