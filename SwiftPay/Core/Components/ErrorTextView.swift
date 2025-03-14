//
//  ErrorTextView.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 05/03/25.
//

import SwiftUI

struct ErrorTextView: View {
    
    let message: String
    
    var body: some View {
        
        HStack {
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.red)
            
            Spacer()
        }
        .padding(.bottom, 16)
        
    }
    
}

struct ErrorTextView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorTextView(message: "Error")
    }
}
