//
//  LogInError.swift
//  FestivalAppMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation
struct LoginError: Error, Equatable {
    let message: String
    
    init(message : String){
        self.message = message
    }
    
    static func ==(lhs: LoginError, rhs: LoginError) -> Bool {
        return lhs.message == rhs.message
    }
}
