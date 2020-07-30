import UIKit

class NetworkManager {
    let baseApi = "http://api.openweathermap.org/data/2.5/"
    let openWatherMapId = "c6e381d8c7ff98f0fee43775817cf6ad"
    
    func starRequest(request: URLRequest, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
   
           completion(data)
        }
        
        task.resume()
    }
    
    
}

extension NetworkManager: WeatherRepository {
    func getWeather(_ location: Location, completion:  @escaping (StationInfo?) -> Void) {
        guard var components = URLComponents(string: baseApi+"weather") else {
            print("bad api")
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: location.lat.string),
            URLQueryItem(name: "lon", value: location.lon.string),
            URLQueryItem(name: "appid", value: openWatherMapId),
            URLQueryItem(name: "units", value: "metrics"),
        ]
        
        guard let url = components.url else {
            print("bad url")
            return
        }
        let request = URLRequest(url: url)
        starRequest(request: request) { (jsonData) in
        let decoder = JSONDecoder()
        let stationInfo = try? decoder.decode(StationInfo.self, from: jsonData)           
        completion(stationInfo)
        }
    }
    
}
