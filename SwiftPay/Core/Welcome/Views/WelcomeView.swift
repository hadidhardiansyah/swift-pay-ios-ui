//
//  WelcomeView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @ObservedObject private var authVM = AuthViewModel.shared
    
    @StateObject private var vm = WelcomeViewModel()
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                
                Image("welcome_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 385)
                
                Spacer()
                
                Text("Welcome to the Swift Pay")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Text("We're excited to help you book and manage your service appointments with ease.")
                    .font(.system(size: 16))
                    .foregroundColor(Color("SecondaryColor"))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button {
                        path.append(NavigationDestination.login)
                    } label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 140, height: 50)
                            .background(.blue)
                            .cornerRadius(12)
                    }
                    
                    Button {
                        path.append(NavigationDestination.registration)
                    } label: {
                        Text("Register")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .frame(width: 160, height: 60)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .login:
                    LoginView(path: $path)
                case .registration:
                    RegistrationView(path: $path)
                case .activation:
                    ActivationView(numberOfFields: 6, path: $path)
                case .activationSuccess:
                    ActivationSuccessView(path: $path)
                }
            }
            .onAppear {
                if authVM.isAuthenticated {
                    path = NavigationPath()
                }
            }
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
