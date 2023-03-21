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
    func login(email : String, password: String) async{
        // verify the email
        
        // if email not valid change the state to emailNotValid
        
        // verify the password
        
        // if password is short change the state to tooShortPassword
        
        // if ok send loggin and change the state to loading
        let result = await self.authService.login(email: email, password: password)
        switch result {
            case .success(let str) : debugPrint("success \(str)")
            case .failure(let error): debugPrint("Error : \(error)")
        }

        // finnaly change the state to loggedIn
    }
    
    // login and change the state of the model to loggedOut
    func logout(){
        self.authService.logout()
    }
}
