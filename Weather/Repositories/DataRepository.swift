protocol DataRepository {
    func getBookmarkedLocations() -> [Location]
    func deleteLocation(_ locationId: String) -> [Location]
}

