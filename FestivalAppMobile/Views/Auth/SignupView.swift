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
    
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    @EnvironmentObject var viewsManager : ViewsManager // for landing
    
    var body: some View {
        
        let signUpIntent : SignUpIntent = SignUpIntent(benevole: benevoleVM)
        
        if benevoleVM.loading{
            ProgressView("We are signing you up ...")
        }else{
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
                    Task {
                        // Here you would implement the code to validate the user's signin credentials
                        // If the validation is successful, set `isShowingHome` to true to take the user to the home screen
                        let signedUp : Bool = await signUpIntent.signUp(email: self.email, password: self.password)
                        if signedUp{
                            self.onSignupSuccess()
                            //land = false
                            viewsManager.land = false
                            isSignupViewPresented = false
                            // show pop up with benevoleVM.signUpSuccessMessage here
                        }else{
                            // pop up or something here
                            print(self.benevoleVM.authErrorMessage)
                        }
                        
                    }
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
}
