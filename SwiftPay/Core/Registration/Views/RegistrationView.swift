//
//  RegistrationView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @StateObject private var vm = RegistrationViewModel()
    @StateObject private var formVM = RegistrationFormViewModel()
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Create an Account")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 24)
                        
                        RegistrationFormView(vm: formVM)
                        
                        AuthButtonsView(
                            authVM: authVM,
                            formVM: formVM,
                            mainVM: vm,
                            canProceed: $formVM.canProceed,
                            path: $path,
                            secondaryButtonText: "Already have an account?",
                            subSecondaryButtonText: "Sign in here",
                            primaryButtonText: "Sign Up",
                            currentPath: "registration"
                        )
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                    
                }
                .scrollDismissesKeyboard(.interactively)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .onChange(of: authVM.isRegistered) { newValue in
                if newValue {
                    path.append(NavigationDestination.activation)
                }
            }
            .alert("Error", isPresented: $authVM.showRegisterErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(authVM.registerErrorMessage)
            }
            .onAppear {
                authVM.resetErrorState()
            }
            
            if authVM.isLoading {
                LoadingView()
            }
        }
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(path: .constant(NavigationPath()))
    }
}
