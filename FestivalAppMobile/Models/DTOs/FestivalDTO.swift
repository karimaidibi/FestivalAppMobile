//
//  FestivalDTO.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

import SwiftUI

class FestivalDTO : Decodable, Encodable, Equatable, Identifiable {
    
    // properties
    var _id : String
    var nom : String
    var annee : Int
    var estCloture : Bool
    
    init(nom : String, annee : Int, estCloture : Bool){
        self.nom = nom
        self.annee = annee
        self.estCloture = estCloture
        self._id = ""
    }
    
    init(festivalVM : FestivalViewModel){
        self._id = festivalVM._id
        self.nom = festivalVM.nom
        self.annee = festivalVM.annee
        self.estCloture = festivalVM.estCloture
    }
    
    static func == (lhs: FestivalDTO, rhs:FestivalDTO) -> Bool {
        return lhs._id == rhs._id
    }
    
}
