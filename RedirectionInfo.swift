import SwiftUI

struct RedirectionInfo: View {
    var body: some View {
        
        ZStack {
            Image("background")
                .saturation(0.69)
                .blur(radius: 0.849)
            
            VStack {
                ExchangeValue(leftImage: .silver, text: "1 Silver coin = 5 Bronze coins", rightImage: .bronze);
                
                ExchangeValue(leftImage: .gold, text: "1 Gold coin = 5 Silver coins", rightImage: .silver);
                
                ExchangeValue(leftImage: .gold, text: "1 Gold coin = 25 Bronze coins", rightImage: .bronze);
            }
        }
    }
}

#Preview {
    RedirectionInfo()
}
