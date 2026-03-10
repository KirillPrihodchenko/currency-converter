import Foundation

enum AlertAttention: String, CaseIterable {
    
    case clarify
    
    public var header: String {
        switch self {
        case .clarify:
            return "Are you sure?"
        }
    }
}

extension AlertAttention {
    
    public var description: String {
        switch self {
        case .clarify:
            return "Are you sure you want to clear text fields and currenccies?"
        }
    }
}
