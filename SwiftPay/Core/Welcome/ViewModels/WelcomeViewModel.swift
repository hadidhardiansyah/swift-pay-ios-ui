//
//  WelcomeViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    
    @Published var isPresentView: Bool = false
    @Published var currentView: ViewStack = .login
    @Published var path = NavigationPath()
    
    enum ViewStack {
        case login
        case registration
    }
    
}


