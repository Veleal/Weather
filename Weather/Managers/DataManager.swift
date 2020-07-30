import UIKit

class DataManager {}

extension DataManager: DataRepository {
    func getBookmarkedLocations() -> [Location] {
        let location = Location()
        location.lat = 48.918408
        location.lon = 24.704253
        return [location]
    }
}
