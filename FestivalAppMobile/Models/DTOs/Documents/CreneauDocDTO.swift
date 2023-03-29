//
//  CreneauDocDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

class CreneauDocDTO : Decodable, Encodable, Hashable{
    
    var _id : String
    var heure_debut : String
    var heure_fin : String
    var idJour : JourDTO?
    
    init(_id : String, heure_debut: String, heure_fin: String, idJour: JourDTO){
        self._id = _id
        self.heure_debut = heure_debut
        self.heure_fin = heure_fin
        self.idJour = idJour
    }
    
    // functions
    static func == (lhs: CreneauDocDTO, rhs: CreneauDocDTO) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
}
