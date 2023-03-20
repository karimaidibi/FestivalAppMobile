//
//  VisitorView.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

import SwiftUI

struct VisitorView: View {
    @State private var isSigninViewPresented = false
    @State private var isSignupViewPresented = false
    @Binding var land: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Mode Visiteur")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
            
            Button(action: {
                isSigninViewPresented = true
            }) {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isSigninViewPresented) {
                SigninView(onSigninSuccess: {
                    self.land = false
                }, land: $land, isSigninViewPresented: $isSigninViewPresented)
            }
            
            Button(action: {
                // Navigate to SignupView
                isSignupViewPresented = true
            }) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isSignupViewPresented) {
                SignupView(onSignupSuccess: {
                    self.isSignupViewPresented = false
                }, isSignupViewPresented: $isSignupViewPresented)
            }
        }
        .padding()
    }
}
