//
//  SignupView.swift
//  FestivalAppMobile
//
//  Created by m1 on 17/03/2023.
//

import Foundation

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    var onSignupSuccess: () -> Void
    @Binding var isSignupViewPresented : Bool
    
    var body: some View {
        VStack {
            Text("Inscription")
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
                // Here you would implement the code to validate the user's signup credentials
                // If the validation is successful, call the `onSignupSuccess` closure to dismiss the `SignupView`
                self.onSignupSuccess()
                isSignupViewPresented = false
            }) {
                Text("S'inscire")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Button(action: {
                // Call the `onSignupSuccess` closure to dismiss the `SignupView`
                self.onSignupSuccess()
            }) {
                Text("Annuler l'inscription")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            .padding(.top, 10)
        }
    }
}
