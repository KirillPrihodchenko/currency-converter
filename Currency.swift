import Foundation

enum Currency: String, CaseIterable, Equatable {
    case bronze = "Bronze"
    case silver = "Silver"
    case gold = "Gold"

    var imageName: String {
        switch self {
        case .bronze: return "bronze"
        case .silver: return "silver"
        case .gold:   return "gold"
        }
    }
}
