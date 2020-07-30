import UIKit

class NetworkManager {
    let baseApi = "http://api.openweathermap.org/data/2.5/"
    let openWatherMapId = "c6e381d8c7ff98f0fee43775817cf6ad"
    
    func starRequest(request: URLRequest, completion: @escaping (Data?, String?) -> Void)  {
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            //let responseString = String(data: data, encoding: .utf8)
            completion(data, self?.errorHandling(data: data, response: response, error: error))
        }
        task.resume()
    }
    
    func errorHandling(data: Data?, response: URLResponse?, error: Error?) -> String? {
        if error != nil {
            return error!.localizedDescription
        } else if  (response as? HTTPURLResponse)!.statusCode > 299 || (response as? HTTPURLResponse)!.statusCode < 200 {
            return String(data: data!, encoding: .utf8)
        } else if error == nil && data == nil {
            return "Unknown error"
        }
        return nil
    }
}

extension NetworkManager: WeatherRepository {
    func getWeather(_ location: Location, completion:  @escaping (StationInfo?, String?) -> Void) {
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
        starRequest(request: request) { (data, error)  in
            guard let jsonData = data else {
                completion(nil, error)
                return;
            }
            let decoder = JSONDecoder()
            let stationInfo = try? decoder.decode(StationInfo.self, from: jsonData)
            completion(stationInfo, error)
        }
    }
    
}
