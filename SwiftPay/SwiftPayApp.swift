//
//  SwiftPayApp.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import SwiftUI

@main
struct SwiftPayApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            WelcomeView()
                .environmentObject(AuthViewModel.shared)
//            ActivationView(numberOfFields: 6)
        }
    }
}
