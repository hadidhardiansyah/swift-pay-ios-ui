//
//  AuthButtonsView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 05/03/25.
//

import SwiftUI

struct AuthButtonsView<T: ObservableObject, V: ObservableObject>: View {
    
    @ObservedObject var authVM: AuthViewModel
    @ObservedObject var formVM: T
    @ObservedObject var mainVM: V
    
    @Binding var canProceed: Bool
    @Binding var path: NavigationPath
    
    @State var secondaryButtonText: String
    @State var subSecondaryButtonText: String
    
    var primaryButtonText: String
    var currentPath: String
    
    
    var body: some View {
        VStack(spacing: 16) {
            Button {
                if let loginVM = mainVM as? LoginViewModel, let loginFormVM = formVM as? LoginFormViewModel {
                    loginVM.login(formVM: loginFormVM)
                } else if let regisVM = mainVM as? RegistrationViewModel, let regisFormVM = formVM as? RegistrationFormViewModel {
                    regisVM.register(formVM: regisFormVM)
                }
                
                authVM.resetErrorState()
            } label: {
                Text(primaryButtonText)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(24)
            }
            .opacity(canProceed ? 1.0 : 0.5)
            .disabled(!canProceed)
            
            HStack {
                VStack { Divider().background(Color.gray) }
                
                Text("or sign in with")
                    .font(.system(size: 14))
                    .foregroundColor(Color("SecondaryColor"))
                    .padding(.horizontal, 8)
                
                VStack { Divider().background(Color("SecondaryColor")) }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            
            Button {
                
            } label: {
                HStack {
                    Image("google_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                    
                    Text("Continue with Google")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("SecondaryColor"))
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color("GrayColor"))
                .foregroundColor(.black)
                .cornerRadius(24)
            }
            
            if currentPath == "login" {
                AuthButtonLoginView(path: $path, secondaryButtonText: secondaryButtonText)
            } else {
                AuthButtonRegisterView(path: $path, secondaryButtonText: secondaryButtonText, subSecondaryButtonText: subSecondaryButtonText)
            }
        }
    }
    
}

struct AuthButtonLoginView: View {
    @Binding var path: NavigationPath
    var secondaryButtonText: String
    
    var body: some View {
        Button {
            path = NavigationPath()
            path.append(NavigationDestination.registration)
        } label: {
            Text(secondaryButtonText)
                .fontWeight(.semibold)
                .padding()
        }
    }
}

struct AuthButtonRegisterView: View {
    @Binding var path: NavigationPath
    var secondaryButtonText: String
    var subSecondaryButtonText: String
    
    var body: some View {
        HStack(spacing: -28) {
            Text(secondaryButtonText)
                .foregroundColor(Color("SecondaryColor"))
                .padding()
            
            Button {
                path = NavigationPath()
                path.append(NavigationDestination.login)
            } label: {
                Text(subSecondaryButtonText)
                    .fontWeight(.semibold)
                    .padding()
            }
        }
    }
}

struct AuthButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let welcomeVm = WelcomeViewModel()
        welcomeVm.currentView = .registration
        
        return AuthButtonsView(authVM: AuthViewModel.shared, formVM: LoginFormViewModel(), mainVM: LoginViewModel(), canProceed: .constant(true), path: .constant(NavigationPath()), secondaryButtonText: "Already have an account?", subSecondaryButtonText: "Sign in here", primaryButtonText: "Sign up", currentPath: "login")
    }
}
