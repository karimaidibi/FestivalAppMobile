//
//  AffectationDocDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation
class AffectationDocDTO : Decodable, Encodable, Equatable, Hashable{
    
    var idZone : ZoneDocDTO
    var idCreneau : CreneauDocDTO
    
    static func == (lhs: AffectationDocDTO, rhs: AffectationDocDTO) -> Bool {
        return lhs.idZone == rhs.idZone &&
               lhs.idCreneau == rhs.idCreneau
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.idZone)
        hasher.combine(self.idCreneau)
    }
}
