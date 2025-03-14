//
//  LoadingView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 10/03/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        Color.black.opacity(0.4)
            .ignoresSafeArea()
        
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .foregroundColor(.white)
            .scaleEffect(1.5)
            .padding()
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
