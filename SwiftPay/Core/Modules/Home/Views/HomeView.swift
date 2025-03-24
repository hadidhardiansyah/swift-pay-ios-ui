//
//  HomeView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 14/03/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        
        VStack {
            if let wallet = vm.walletData {
                CardView(wallet: wallet)
            } else if vm.isLoading {
                ProgressView()
            } else if let error = vm.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("No Data")
            }
        }
        .onAppear {
            if vm.walletData == nil {
                vm.getWallet()
            }
        }

        
        TabBarView()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let tabBarViewModel = TabBarViewModel()
        HomeView(vm: tabBarViewModel.homeViewModel)
    }
}
