import Foundation

extension URLSession {
    
    func fetchData(at url: URL, completion: @escaping (Result<CurrencyResponse, Error>) -> Void) {
        
        self.dataTask(with: url) { data, _, error in
            if let errorData = error {
                completion(.failure(errorData))
                return
        }
        
        guard let data = data else {
            return
        }
            
        do {
            let dataFetch = try JSONDecoder().decode(CurrencyResponse.self, from: data)
            DispatchQueue.main.async {
                completion(.success(dataFetch))
            }
        } catch let decoderError {
            DispatchQueue.main.async {
                completion(.failure(decoderError))
            }
        }
    }.resume()
  }
}
