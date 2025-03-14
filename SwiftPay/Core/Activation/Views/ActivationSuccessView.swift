//
//  ActivationSuccessView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 10/03/25.
//

import SwiftUI

struct ActivationSuccessView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        VStack {
            Image("success_image")
                .resizable()
                .scaledToFit()
                .frame(width: 350)
            
            Text("🎉 Congratulations!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            Text("Your account has been successfully created. You can now log in and start using SwiftPay to manage your transactions effortlessly. Stay secure and enjoy a seamless payment experience! 🚀")
                .font(.system(size: 16))
                .foregroundColor(Color("SecondaryColor"))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                path = NavigationPath([NavigationDestination.login])
            } label: {
                Text("Sign in here")
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            
            
            Spacer()
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ActivationSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ActivationSuccessView(path: .constant(NavigationPath()))
    }
}
