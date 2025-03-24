//
//  LoginView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @StateObject private var vm = LoginViewModel()
    @StateObject private var formVM = LoginFormViewModel()
    
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Login")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("Welcome back! Manage your money easily")
                                .font(.system(size: 16))
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 24)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                vm.selectedOption = .email
                            }) {
                                VStack(spacing: 4) {
                                    Text("Email")
                                        .fontWeight(.semibold)
                                        .foregroundColor(vm.selectedOption == .email ? .blue : .gray)
                                    
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: 20, height: 2)
                                        .foregroundColor(vm.selectedOption == .email ? .blue : .clear)
                                }
                            }
                            
                            Button(action: {
                                vm.selectedOption = .phoneNumber
                            }) {
                                VStack(spacing: 4) {
                                    Text("Phone Number")
                                        .fontWeight(.semibold)
                                        .foregroundColor(vm.selectedOption == .phoneNumber ? .blue : .gray)
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: 30, height: 2)
                                        .foregroundColor(vm.selectedOption == .phoneNumber ? .blue : .clear)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                        
                        LoginFormView(
                            vm: formVM,
                            selectedOption: vm.selectedOption
                        )
                        
                        AuthButtonsView(authVM: authVM, formVM: formVM, mainVM: vm, canProceed: $formVM.canProceed, path: $path, secondaryButtonText: "Create an account", subSecondaryButtonText: "sdasd", primaryButtonText: "Login", currentPath: "login")
                        
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                }
                .scrollDismissesKeyboard(.interactively)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .onChange(of: authVM.isAuthenticated, perform: { isAuthenticated in
                if isAuthenticated {
                    path = NavigationPath()
                }
            })
            .onAppear {
                authVM.resetErrorState()
            }
            if authVM.isLoading {
                LoadingView()
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(path: .constant(NavigationPath()))
    }
}
