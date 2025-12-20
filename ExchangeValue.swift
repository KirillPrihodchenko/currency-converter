import SwiftUI

struct ExchangeValue: View {
    
    let leftImage: ImageResource
    let text: String
    let rightImage: ImageResource
    
    var body: some View {
        
        HStack() {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(text)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
        }
    }
}

#Preview {
    ExchangeValue(leftImage: .silver, text: "1 Silver coin = 5 Bronze coins", rightImage: .bronze)
}
