import UIKit

class DataManager {
    let defaults = UserDefaults.standard
}

extension DataManager: DataRepository {
    func getBookmarkedLocations() -> [Location] {
        if defaults.object(forKey: "bookmarkedLocations") != nil {
            if let data = UserDefaults.standard.value(forKey: "bookmarkedLocations") as? Data {
                let locations = try? PropertyListDecoder().decode([Location].self, from: data)
                return locations!
            }
        }
        return []
    }
    
    func deleteLocation(_ locationId: String) -> [Location] {
        var locations = getBookmarkedLocations()
        locations.removeAll(where: {$0.id == locationId})
        let encodedData = try! PropertyListEncoder().encode(locations)
        defaults.set(encodedData, forKey: "bookmarkedLocations")
        return locations
    }
    
}

extension DataManager: MapRepository {
    func saveLocation(location: Location) {
        var locations = getBookmarkedLocations()
        locations.append(location)
        let encodedData = try! PropertyListEncoder().encode(locations)
        defaults.set(encodedData, forKey: "bookmarkedLocations")
        print("")
    }
}
