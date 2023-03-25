//
//  Affectation.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation

class AffectationDTO: Decodable, Encodable, Equatable {
    
    var idZone: String
    var idCreneau: String
    
    init(idZone : String, idCreneau : String){
        self.idZone = idZone
        self.idCreneau = idCreneau
    }
    
    static func == (lhs: AffectationDTO, rhs: AffectationDTO) -> Bool {
        return lhs.idZone == rhs.idZone &&
               lhs.idCreneau == rhs.idCreneau
    }
}
