import Foundation
import Combine

class Currency: ObservableObject {
    
    @Published var currencies: [String: Double] = [:]
    private let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=API_KEY")!
    
    func fetchData() {
        URLSession.shared.fetchData(at: url) { result in
            switch result {
            
            case .success(let fetchedData):
                DispatchQueue.main.async {
                    fetchedData.data.forEach { key, value in
                        self.currencies[key] = value
                    }
                }
                    
            case .failure:
                let error = CurrencyInputError.errorDataFetch
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
    }
}
