//
//  SignUpDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

class SignUpDTO : Decodable, Encodable{
    
    var nom : String
    var prenom : String
    var email : String
    var password : String
    var affectations : [AffectationDTO]
    var isAdmin : Bool
    
    init(nom : String, prenom : String, email : String, password : String, affectations : [AffectationDTO], isAdmin : Bool){
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.password = password
        self.affectations = affectations
        self.isAdmin = isAdmin
    }
}
