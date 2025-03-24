//
//  CardView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 24/03/25.
//

import SwiftUI

struct CardView: View {
    
    @State private var isVisible = true
    
    let wallet: WalletModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Balance")
                .foregroundColor(.white)
                .font(.body)
                .fontWeight(.semibold)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(isVisible ? formatBalance(wallet.balance) : "************")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .monospacedDigit()
                    
                    
                    Spacer()
                    
                    Image(systemName: isVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.white)
                        .onTapGesture {
                            isVisible.toggle()
                        }
                        .animation(.easeInOut, value: isVisible)
                }
                
                Text(formatPhoneNumber(wallet.user.phoneNumber))
                    .foregroundColor(.white)
                    .font(.body)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Text("\(wallet.user.firstName) \(wallet.user.lastName)")
                .foregroundColor(.white)
                .font(.body)
                .fontWeight(.semibold)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: 220, alignment: .leading)
        .background(
            ZStack {
                Color("BlueCardColor")
                
                GeometryReader { geometry in
                    Circle()
                        .fill(Color("BlueCircleColor"))
                        .frame(width: 200, height: 200)
                        .position(x: geometry.size.width - 50, y: geometry.size.height - 50)
                }
            }
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 4, y: 4)
        .clipped()
        .padding()
        
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = UserModel(id: 1, firstName: "John", lastName: "Doe", phoneNumber: "123123123", username: "johndue", email: "john@example.com", enabled: true)
        let sampleWallet = WalletModel(id: 1, user: sampleUser, balance: 29000000, createdAt: "2025-03-24")
        
        CardView(wallet: sampleWallet)
    }
}
