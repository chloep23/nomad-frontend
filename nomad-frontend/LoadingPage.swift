//
//  LoginPage.swift
//  testnomad
//
//  Created by Sara Wan on 2/5/25.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack {
            Image("nomadicon")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 248/255, blue: 228/255))

    }
        
}

#Preview {
    LoadingPage()
}
