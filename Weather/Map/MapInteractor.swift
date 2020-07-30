
class MapInteractor {
    private let mapRepository: MapRepository!
    
    init(mapRepository: MapRepository) {
        self.mapRepository = mapRepository
    }
    
    func saveLocation(location: Location, completion: @escaping (Bool) -> Void) {
        mapRepository.saveLocation(location: location)
        completion(true)
    }
}
