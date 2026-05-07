import SwiftUI
internal import CoreData

struct HistoryView: View {
    
    @State private var statusNotification: Status = .success()
    private let txRecordManagerVM: TransactionRecordManager
    
    init(txRecordManagerVM: TransactionRecordManager) {
        self.txRecordManagerVM = txRecordManagerVM
    }
    
    var body: some View {
        ZStack() {
            Image("background")
                .resizable()
            
            Color/*(red: 0.4118127525, green: 0.4118127525, blue: 0.4118127525)*/.black.opacity(0.6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 59)
                    .frame(maxHeight: .infinity, alignment: .top)
                    //.frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea(edges: .top)
                    //.ignoresSafeArea(edges: .bottom)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(txRecordManagerVM.readAllTransactionRecords()) { index in
                    VStack(alignment: .leading) {
                        Text("Status: ").foregroundStyle(Color.white) + Text("\(index.status ?? "Unknown")")
                            .foregroundStyle(statusNotification.color)
                            .bold()
                        Text("Currency From: \(index.currencyFrom ?? "Unknown")").foregroundStyle(Color.white)
                        Text("Currency To: \(index.currencyTo ?? "Unknown")").foregroundStyle(Color.white)
                        Text("Amount: \(index.amount ?? 0.0)").foregroundStyle(Color.white)
                        Text("Result: \(index.result ?? 0.0)").foregroundStyle(Color.white)
                        Text("Username: \(index.userId?.username ?? "Unknown")").foregroundStyle(Color.white)
                        Text("Time: \(index.createdAt ?? Date())").foregroundStyle(Color.white)
                    }
                    .padding()
                    .background(Color.clear)
                    .frame(maxWidth: 375, maxHeight: 350)
                }
                .scrollDisabled(false)
            }
        }
        .safeAreaInset(edge: .top) {
            Color.clear.frame(height: 0)
        }
        .safeAreaInset(edge: .bottom) {
            Color(red: 0.4118127525, green: 0.4118127525, blue: 0.4118127525)
                .frame(height: 45)
                .ignoresSafeArea()
        }

//        .safeAreaPadding(.top, 10.0)
//        .safeAreaPadding(.bottom, 45.0)/*.foregroundStyle(Color(red: 0.4118127525, green: 0.4118127525, blue: 0.4118127525))*/
        .clipped()
    }
}

#Preview {
    
    let context = PersistenceController.shared.container.viewContext
    let manager = TransactionRecordManager(context: context)
    HistoryView(txRecordManagerVM: manager)
}
