//
//  CustomTabBar.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 18/03/25.
//

import SwiftUI

struct CustomTabBar: View {
    
    @ObservedObject var vm: TabBarViewModel
    var tint: Color = .blue
    var inactiveTint: Color = .gray
    var animation: Namespace.ID
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(TabModel.allCases, id: \.rawValue) { tab in
                TabItemView(
                    tab: tab,
                    animation: animation,
                    activeTab: $vm.activeTab,
                    position: $vm.tabShapePosition.x,
                    tint: tint,
                    inactiveTint: inactiveTint,
                    onTap: {
                        vm.switchTab(to: tab)
                    }
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            TabShape(midpoint: vm.tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: vm.activeTab)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        CustomTabBar(vm: TabBarViewModel(), animation: animation)
            .previewLayout(.sizeThatFits)
            .background(Color.gray.opacity(0.1))
    }
}
