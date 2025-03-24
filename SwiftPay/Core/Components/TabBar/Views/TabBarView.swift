//
//  TabBarView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 18/03/25.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject private var vm = TabBarViewModel()
    
    @Namespace private var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $vm.activeTab) {
                HomeView(vm: vm.homeViewModel)
                    .tag(TabModel.home)
                
                Text("Activity")
                    .tag(TabModel.activity)
                
                Text("Wallet")
                    .tag(TabModel.wallet)
                
                Text("Profile")
                    .tag(TabModel.profile)
            }
            
            CustomTabBar(vm: vm, animation: animation)
        }
    }

}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
