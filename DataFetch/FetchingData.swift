
//import Foundation
//
//final class FetchingData: ObservableObject {
//    
//    private let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_xVY78JHNOUtu44Y6qJ64EPUZu9HMTgTWTBpHwEhn")!
//    
//    func fetchData() {
//        URLSession.shared.fetchData(at: url) { result in
//            switch result {
//            case .success(let fetchedData):
//                
//            
//            case .failure:
//                
//                let error = CurrencyInputError.errorDataFetch
//                print("Fetch failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
