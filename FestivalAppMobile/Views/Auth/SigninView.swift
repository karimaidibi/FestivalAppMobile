//
//  Signin.swift
//  FestivalAppMobile
//
//  Created by m1 on 17/03/2023.
//

import Foundation
import SwiftUI

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    var onSigninSuccess: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Connexion")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                SecureField("Mot de passe", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                Button(action: {
                    // Here you would implement the code to validate the user's signin credentials
                    // If the validation is successful, set `isShowingHome` to true to take the user to the home screen
                    self.onSigninSuccess()
                }) {
                    Text("Se connecter")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
