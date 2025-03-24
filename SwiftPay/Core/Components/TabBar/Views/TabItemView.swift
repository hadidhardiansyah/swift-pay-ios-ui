//
//  TabItemView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 24/03/25.
//

import SwiftUI

struct TabItemView: View {
    var tab: TabModel
    var animation: Namespace.ID
    
    @Binding var activeTab: TabModel
    @Binding var position: CGFloat
    
    var tint: Color
    var inactiveTint: Color
    
    var onTap: (() -> Void)?
    
    @State private var tabPosition: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 5) {
            Image(tab.imagePath)
                .renderingMode(.template)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVE_TAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : inactiveTint)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition { rect in
            tabPosition = rect.midX
            if activeTab == tab {
                position = tabPosition
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                activeTab = tab
                position = tabPosition
                onTap?()
            }
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        TabItemView(
            tab: .home,
            animation: animation,
            activeTab: .constant(.home),
            position: .constant(0),
            tint: .blue,
            inactiveTint: .gray
        )
        .previewLayout(.sizeThatFits)
        .background(Color.gray.opacity(0.1))
    }
}
