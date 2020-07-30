import Foundation

class DateManager {
    static func getStringDate(timestamp: UInt32, timeZone: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}
