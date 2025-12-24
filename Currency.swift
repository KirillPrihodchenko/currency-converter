import Foundation

enum Currency: String, CaseIterable, Equatable {
    case bronze
    case silver
    case gold 

    var imageName: String {
        switch self {
        case .bronze: return "bronze"
        case .silver: return "silver"
        case .gold:   return "gold"
        }
    }
}
