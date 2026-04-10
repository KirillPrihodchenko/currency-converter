import Foundation
import SwiftUI

enum Status {
    
    case success(color: Color = .green)
    case failure(color: Color = .red)
    case loading(color: Color = .gray)
    
    var color: Color {
        switch self {
            case .success(let color), .failure(let color), .loading(let color):
                return color
        }
    }
}

extension Status {
    
    var name: String {
        switch self {
            case .success:
                return "Success"
            case .failure:
                return "Failure"
            case .loading:
                return "Loading"
        }
    }
}

