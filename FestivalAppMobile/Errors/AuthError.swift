//
//  LogInError.swift
//  FestivalAppMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation
struct AuthError: Error, Equatable {
    let message: String
    
    init(message : String){
        self.message = message
    }
    
    static func ==(lhs: AuthError, rhs: AuthError) -> Bool {
        return lhs.message == rhs.message
    }
}
