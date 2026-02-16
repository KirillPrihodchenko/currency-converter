import SwiftUI

struct RedirectionInfo: View {
    var body: some View {
        
        ZStack {
            Image("background")
                .saturation(0.69)
                .blur(radius: 0.849)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    InstructionRow(number: "1", text: "Press 'Fetch' to load currency data")
                    InstructionRow(number: "2", text: "Select currencies to convert between")
                    InstructionRow(number: "3", text: "Enter amount (positive numbers only)")
                    InstructionRow(number: "4", text: "Press 'Calculate' to see the result")
                    InstructionRow(number: "5", text: "Press 'Clear' to reset all data")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.1))
                )
                .padding(.vertical)
            }
            .frame(maxHeight: 300)
        }
    }
}

struct InstructionRow: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Circle().fill(Color.white.opacity(0.2)))
            
            Text(text)
                .font(.body)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    RedirectionInfo()
}
