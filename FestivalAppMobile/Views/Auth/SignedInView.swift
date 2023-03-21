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
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    
    var body: some View {
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        
        VStack(spacing: 40) {
            Text("Bienvenue \(username) !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Implement log out functionality here
                benevoleIntent.logout()
                print("after logged out  \(AuthManager.getBenevoleId())")
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
