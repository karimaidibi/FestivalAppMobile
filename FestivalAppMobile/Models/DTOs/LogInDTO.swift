//
//  LogInDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation

class LogInDTO : Encodable {
    var email : String
    var password : String
    
    init(email : String, password: String){
        self.email = email
        self.password = password
    }
}
