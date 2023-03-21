//
//  BenevoleIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleIntent{
    @ObservedObject private var model : BenevoleViewModel
    private var authService : AuthService = AuthService()
    private var benevoleService : BenevoleService = BenevoleService()
    
    init(benevole : BenevoleViewModel){
        self.model = benevole
    }
    
    // login and change the state of the model to loggedIn
    func login(email : String, password: String) async -> Bool{
        // set email to lower case :
        
        let lowercasedEmail = email.lowercased()
        
        // Verify the email
         if !validateEmail(lowercasedEmail) {
             // If email is not valid, change the state to emailNotValid
             model.state = .emailNotValid
             return false
         }
         
         // Verify the password
         if password.count < 5 { // Assuming the minimum password length is 8 characters
             // If password is short, change the state to tooShortPassword
             model.state = .tooShortPassword
             return false
         }
        
        // if ok send loggin and change the state to loading
        model.state = .loading
        let result = await self.authService.login(email: lowercasedEmail, password: password)
        switch result {
            case .success(_) :
            	model.state = .loggedIn(lowercasedEmail)
                return true
            case .failure(let error):
                model.state = .logInFailed(error as! LoginError)
                return false
        }
    }
    
    // login and change the state of the model to loggedOut
    func logout(){
        self.authService.logout()
    }
    
    // Validate email function
    private func validateEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: email)
    }
}
