//
//  ActivationView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 07/03/25.
//

import SwiftUI

struct ActivationView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @StateObject private var vm: ActivationViewModel
    
    @FocusState private var focusedField: Int?
    
    @Binding var path: NavigationPath
    
    init(numberOfFields: Int, path: Binding<NavigationPath>) {
        _vm = StateObject(wrappedValue: ActivationViewModel(numberOfFields: numberOfFields))
        _path = path
    }
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Activation Code")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Enter the activation code we just sent on your email.")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SecondaryColor"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 40)
                
                HStack {
                    ForEach(0..<vm.numberOfFields, id: \.self) { index in
                        TextField("0", text: $vm.enterValue[index])
                            .frame(width: 20, height: 20)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color("BlueColor"))
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: index)
                            .onChange(of: vm.enterValue[index]) { newValue in
                                vm.updateValue(index: index, newValue: newValue)
                                focusedField = vm.focusedField
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(focusedField == index ? .blue : .white, lineWidth: 3)
                            )
                    }
                }
                
                Button {
                    vm.activateAccount(token: vm.enterValue.joined())
                } label: {
                    if authVM.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    } else {
                        Text("Activate")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(24)
                    }
                }
                .padding(.bottom, 40)
                .opacity(vm.canProceed || authVM.isLoading ? 1.0 : 0.5)
                .disabled(!vm.canProceed || authVM.isLoading )
                
                VStack(spacing: 16) {
                    Text("Activation Code in")
                        .font(.system(size: 16))
                    
                    
                    Button {
                        // CALL API RESEND CODE ACTIVATE
                    } label: {
                        Text("Resend Code")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            .alert("Error", isPresented: $authVM.showActivationErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(authVM.activationErrorMessage)
            }
            .onAppear {
                authVM.resetErrorState()
            }
            .navigationBarBackButtonHidden(true)
            .onChange(of: authVM.isActivated) { newValue in
                if newValue {
                    path.append(NavigationDestination.activationSuccess)
                }
            }
            
            if authVM.isLoading {
                LoadingView()
            }
        }
        
    }
}


struct ActivationView_Previews: PreviewProvider {
    static var previews: some View {
        ActivationView(
            numberOfFields: 6,
            path: .constant(NavigationPath())
        )
    }
}
