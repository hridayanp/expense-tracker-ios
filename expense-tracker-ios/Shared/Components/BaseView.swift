//
//  BaseView.swift
//  expense-tracker-ios
//
//  Created by Hridayan Phukan on 04/03/25.
//

import SwiftUI

struct BaseView<Content: View>: View {
    let backgroundColor: Color
    let content: Content
    
    init(backgroundColor: Color, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all) // Ensure full-screen background
            
            content // Embed the child views
        }
    }
}
