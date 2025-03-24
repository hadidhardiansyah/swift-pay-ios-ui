//
//  ContentView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel.shared
    
    var body: some View {
        if authViewModel.isAuthenticated {
            TabBarView() // Hanya panggil TabBarView di sini
        } else {
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
