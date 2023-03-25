//
//  JoursDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

class JourDTO: Decodable, Encodable, Equatable, Identifiable {
    
    var _id : String
    var date : String
    var nom : String
    var heure_ouverture : String
    var heure_fermeture : String
    var idFestival : String
    
    static func == (lhs: JourDTO, rhs:JourDTO) -> Bool {
        return lhs._id == rhs._id
    }
    
}
