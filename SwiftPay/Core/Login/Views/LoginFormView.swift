//
//  LoginFormView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import SwiftUI

struct LoginFormView: View {
    
    enum FocusedField {
        case email
        case password
    }
    
    @ObservedObject var vm: LoginFormViewModel
    @ObservedObject var authVM = AuthViewModel.shared
    
    @FocusState private var focusedField: FocusedField?
    
    @State private var isValidEmail: Bool = true
    @State private var isValidPassword: Bool = true
    
    let selectedOption: LoginViewModel.LoginOption
    
    var body: some View {
        
        VStack {
            if selectedOption == .email {
                EmailLoginView(
                    email: $vm.email, password: $vm.password, isValidEmail: $isValidEmail, isValidPassword: $isValidPassword, focusedField: $focusedField)
            }
            
            if authVM.showLoginErrorAlert {
                Text(authVM.loginErrorMessage)
                    .foregroundColor(.red)
            }
            
        }
        .padding(.bottom, 24)
        
    }
}

struct EmailLoginView: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var isValidEmail: Bool
    @Binding var isValidPassword: Bool
    
    @FocusState.Binding var focusedField: LoginFormView.FocusedField?
    
    var body: some View {
        
        Text("Email / Username")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        TextField("Email", text: $email)
            .focused($focusedField, equals: .email)
            .padding()
            .background(Color("BlueColor"))
            .cornerRadius(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(!isValidEmail ? .red : focusedField == .email ? .blue : .white, lineWidth: 3)
            )
            .onChange(of: email) { newValue in
                isValidEmail = Validator.validateEmail(newValue)
            }
            .autocapitalization(.none)
            .autocorrectionDisabled(true)
        
        if !isValidEmail {
            ErrorTextView(message: "Your email is not valid format")
        }
        
        HStack {
            Text("Password")
                .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                //
            } label: {
                Text("Forgot Password?")
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
            }
        }
        .padding(.top, isValidEmail ? 16 : 0)
        
        SecureField("Password", text: $password)
            .focused($focusedField, equals: .password)
            .padding()
            .background(Color("BlueColor"))
            .cornerRadius(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(!isValidPassword ? .red : focusedField == .password ? .blue : .white, lineWidth: 3)
            )
            .onChange(of: password) { newValue in
                isValidPassword = Validator.validatePassword(newValue)
            }
        
        if !isValidPassword {
            ErrorTextView(message: "Password must include an uppercase letter, a number, and a special character")
        }
        
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(vm: LoginFormViewModel(), selectedOption: .email)
            .environmentObject(AuthViewModel.shared)
    }
}
