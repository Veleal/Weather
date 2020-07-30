final class Condition {
static func weatherSymbol(fromWeatherCode code: Int?) -> String {
  guard let code = code else {
    return "❓"
  }
  switch code {
  case let x where (x >= 200 && x <= 202) || (x >= 230 && x <= 232):
    return "⛈"
  case let x where x >= 210 && x <= 211:
    return "🌩"
  case let x where x >= 212 && x <= 221:
    return "⚡️"
  case let x where x >= 300 && x <= 321:
    return "🌦"
  case let x where x >= 500 && x <= 531:
    return "🌧"
  case let x where x >= 600 && x <= 602:
    return "☃️"
  case let x where x >= 603 && x <= 622:
    return "🌨"
  case let x where x >= 701 && x <= 771:
    return "🌫"
  case let x where x == 781 || x == 900:
    return "🌪"
  case let x where x == 800:
    return "☀️"
  case let x where x == 801:
    return "🌤"
  case let x where x == 802:
    return "⛅️"
  case let x where x == 803:
    return "🌥"
  case let x where x == 804:
    return "☁️"
  case let x where x >= 952 && x <= 956 || x == 905:
    return "🌬"
  case let x where x >= 957 && x <= 961 || x == 771:
    return "💨"
  case let x where x == 901 || x == 902 || x == 962:
    return "🌀"
  case let x where x == 903:
    return "❄️"
  case let x where x == 904:
    return "🌡"
  case let x where x == 962:
    return "🌋"
  default:
    return "❓"
  }
}
}
