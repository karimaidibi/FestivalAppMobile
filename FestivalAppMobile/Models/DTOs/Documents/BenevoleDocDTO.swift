//
//  BenevoleDoc.swift
//  FestivalAppMobile
//
//  Created by m1 on 31/03/2023.
//


import Foundation
import SwiftUI

class BenevoleDocDTO : Decodable, Encodable, Equatable {
    
    // properties
    var _id : String
    var nom : String
    var prenom : String
    var email : String
    var password : String
    var affectations : [AffectationDocDTO]
    var isAdmin : Bool
    
    
    static func == (lhs: BenevoleDocDTO, rhs: BenevoleDocDTO) -> Bool {
        return lhs._id == rhs._id
    }

    
}

