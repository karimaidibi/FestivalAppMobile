//
//  CreneauDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

class CreneauDTO : Decodable, Encodable{
    
    var _id : String
    var heure_debut : String
    var heure_fin : String
    var idJour : String //String || JourDTO
    
    init(_id : String, heure_debut: String, heure_fin: String, idJour: String){
        self._id = _id
        self.heure_debut = heure_debut
        self.heure_fin = heure_fin
        self.idJour = idJour
    }
}
