//
//  RegisterFormView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 06/03/25.
//

import SwiftUI

struct RegistrationFormView: View {
    
    enum FocusedField {
        case firstName
        case lastName
        case phoneNumber
        case username
        case email
        case password
    }
    
    @ObservedObject var vm: RegistrationFormViewModel
    
    @FocusState private var focusedField: FocusedField?
    
    
    @State private var isValidFirstName: Bool = true
    @State private var isValidLastName: Bool = true
    @State private var isValidPhoneNumber: Bool = true
    @State private var isValidUsername: Bool = true
    @State private var isValidEmail: Bool = true
    @State private var isValidPassword: Bool = true
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            FieldFormView(
                label: "First Name",
                placeholder: "First name",
                text: $vm.firstName,
                focusedField: .firstName,
                isValid: $isValidFirstName,
                validationMessage: "First name is required",
                validationRule: { !$0.isEmpty }
            )
            
            FieldFormView(
                label: "Last Name",
                placeholder: "Last name",
                text: $vm.lastName,
                focusedField: .lastName,
                isValid: $isValidLastName,
                validationMessage: "Last name is required",
                validationRule: { !$0.isEmpty }
            )
            
            
            PhoneNumberField(
                label: "Phone Number",
                placeholder: "Phone number",
                text: $vm.phoneNumber,
                isValid: $isValidPhoneNumber,
                validationMessage: "Phone number must be between 10 and 13 digits",
                validationRule: Validator.validatePhoneNumber
            )
            
            FieldFormView(
                label: "Username",
                placeholder: "Username",
                text: $vm.username,
                focusedField: .username,
                isValid: $isValidUsername,
                validationMessage: "Username is required",
                validationRule: { !$0.isEmpty }
            )
            
            
            FieldFormView(
                label: "Email",
                placeholder: "Enter your email address",
                text: $vm.email,
                focusedField: .email,
                isValid: $isValidEmail,
                validationMessage: "Your email is not valid format",
                validationRule: Validator.validateEmail
            )
            
            PasswordField(
                label: "Password",
                placeholder: "Enter your password",
                text: $vm.password,
                isValid: $isValidPassword,
                validationMessage: "Password must include an uppercase letter, a number, and a special character",
                validationRule: Validator.validatePassword
            )
        }
        
    }
}

struct FieldFormView: View {
    
    var label: String
    var placeholder: String
    @Binding var text: String
    var focusedField: RegistrationFormView.FocusedField
    @FocusState private var isFocused: Bool
    @Binding var isValid: Bool
    var validationMessage: String?
    var validationRule: (String) -> Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .padding()
                .background(Color("BlueColor"))
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValid ? .red : isFocused ? .blue : .white, lineWidth: 3)
                )
                .onChange(of: text) { newValue in
                    isValid = validationRule(newValue)
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
            
            
            
            if let message = validationMessage, !isValid {
                ErrorTextView(message: message)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: isValid)
            }
        }
    }
}

struct PhoneNumberField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    @Binding var isValid: Bool
    var validationMessage: String?
    var validationRule: (String) -> Bool
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .keyboardType(.numberPad)
                .padding()
                .background(Color("BlueColor"))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValid ? .red : isFocused ? .blue : .white, lineWidth: 3)
                )
                .onChange(of: text) { newValue in
                    isValid = validationRule(newValue)
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
            
            if let message = validationMessage, !isValid {
                Text(message)
                    .foregroundColor(.red)
                    .font(.caption)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: isValid)
            }
        }
    }
}

struct PasswordField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    @Binding var isValid: Bool
    var validationMessage: String?
    var validationRule: (String) -> Bool
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SecureField(placeholder, text: $text)
                .focused($isFocused)
                .padding()
                .background(Color("BlueColor"))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValid ? .red : isFocused ? .blue : .white, lineWidth: 3)
                )
                .onChange(of: text) { newValue in
                    isValid = validationRule(newValue)
                }
                .autocapitalization(.none)
                .autocorrectionDisabled(true)
            
            if let message = validationMessage, !isValid {
                Text(message)
                    .foregroundColor(.red)
                    .font(.caption)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: isValid)
            }
        }
    }
}

struct RegisterFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView(vm: RegistrationFormViewModel())
    }
}
