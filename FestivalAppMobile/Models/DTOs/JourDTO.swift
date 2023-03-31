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
    
    init(date : String, nom : String, heure_ouverture : String, heure_fermeture : String ,idFestival : String){
        self.date = date
        self.nom = nom
        self.heure_ouverture = heure_ouverture
        self.heure_fermeture = heure_fermeture
        self.idFestival = idFestival
        self._id = ""
    }
    
    init(jourVM : JourViewModel){
        self._id = jourVM._id
        self.date = jourVM.date
        self.nom = jourVM.nom
        self.heure_ouverture = jourVM.heure_ouverture
        self.heure_fermeture = jourVM.heure_fermeture
        self.idFestival = jourVM.idFestival
    }
    
    static func == (lhs: JourDTO, rhs:JourDTO) -> Bool {
        return lhs._id == rhs._id
    }
    
}
