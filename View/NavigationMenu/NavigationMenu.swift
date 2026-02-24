import SwiftUI

struct NavigationMenu: View {
    
    @State private var selectedButton: NavigationMenuDecription = .converter
        
        var body: some View {
            VStack(spacing: -80) {
                Group {
                    switch selectedButton {
                    case .account:
                        NavigationStack {
                            AccountView()
                        }
                    case .converter:
                        NavigationStack {
                            MainContentView()
                        }
                    case .history:
                        NavigationStack {
                            HistoryView()
                        }
                    case .info:
                        NavigationStack {
                            RedirectionInfo()
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack(spacing: 25) {
                    ForEach(NavigationMenuDecription.allCases, id: \.self) { title in
                        Button {
                            selectedButton = title
                        } label: {
                            HStack() {
                                Image(title.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.8)
                                    .frame(width: 24, height: 24)
                                
                                if selectedButton == title {
                                    Text(title.title)
                                        .foregroundStyle(.black.opacity(0.8))
                                        .transition(.opacity)
                                        .lineLimit(1)
                                        .background(Color(.gray).opacity(0.1))
                                }
                            }
                            .font(.system(size: 15, weight: .medium))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .foregroundColor(.primary)
                .background(
                    Color.primary
                        .colorInvert()
                        .opacity(0.75))
                .cornerRadius(28)
            }
        }
    }

#Preview {
    NavigationMenu()
}
