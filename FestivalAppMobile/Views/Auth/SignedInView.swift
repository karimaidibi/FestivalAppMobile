//
//  SignedInView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct SignedInView: View {
    let username: String
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Bienvenue \(username) !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Implement log out functionality here
                }) {
                Text("Déconnexion")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
