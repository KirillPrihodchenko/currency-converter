import Foundation
import Combine

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

class CurrencyA: ObservableObject {
    
    @Published var currencies: [String: Double] = [:]
    private let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=API_KEY")!
    
    func fetchData() {
        URLSession.shared.fetchData(at: url) { result in
            switch result {
            
            case .success(let fetchedData):
                
                return fetchedData.data.forEach { key, value in
                    self.currencies[key] = value
                }
                    
            case .failure:
                let error = CurrencyInputError.errorDataFetch
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
    }
}
