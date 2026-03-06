import SwiftUI
internal import CoreData

struct HistoryView: View {
    
    private let txRecordManagerVM: TransactionRecordManager
   
    init(txRecordManagerVM: TransactionRecordManager) {
        self.txRecordManagerVM = txRecordManagerVM
    }
    
    var body: some View {
        ZStack {
            Image("background")
            
            List {
                ForEach(txRecordManagerVM.readAllTransactionRecords()) { index in
                    LazyVStack(alignment: .leading, spacing: 8) {
                        Text("Status: \(index.status ?? "Unknown")")
                        Text("Currency From: \(index.currencyFrom ?? "Unknown")")
                        Text("Currency To: \(index.currencyTo ?? "Unknown")")
                        Text("Amount: \(index.amount ?? 0.0)")
                        Text("Result: \(index.result ?? 0.0)")
                        Text("Username: \(index.userId?.username ?? "Unknown")")
                        Text("Time: \(index.createdAt ?? Date())")
                    }
                    Spacer()
                        .background(Color.gray)
                }
            }
            .frame(maxWidth: 375, maxHeight: 640, alignment: .center)
            .scrollContentBackground(.hidden)
            
        }
    }
}

#Preview {
    
    let context = PersistenceController.shared.container.viewContext
    let manager = TransactionRecordManager(context: context)
    HistoryView(txRecordManagerVM: manager)
}
