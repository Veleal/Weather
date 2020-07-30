
struct StationInfo: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let rain: Rain
    let clouds: Cloud
    let name: String
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

struct Rain: Codable {
    let one_hour: Double
    
    enum CodingKeys: String, CodingKey {
        case one_hour = "1h"
    }
}

struct Cloud: Codable {
    let all: Int
}
