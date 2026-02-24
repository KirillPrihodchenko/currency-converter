import Foundation

enum NavigationMenuDecription: String, CaseIterable, Equatable {

    case converter
    case account
    case history
    case info
    
    var title: String {
        switch self {
        case .converter: return "Transfer"
        case .account: return "Account"
        case .history: return "History"
        case .info: return "Info"
        }
    }
    
    var icon: String {
        switch self {
        case .converter: return "transferImage"
        case .account: return "accountImage"
        case .history: return "historyImage"
        case .info: return "infoImage"
        }
    }
}
