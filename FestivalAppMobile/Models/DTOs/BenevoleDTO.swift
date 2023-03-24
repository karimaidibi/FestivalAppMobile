//
//  BenevoleDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

class BenevoleDTO : Decodable, Encodable {
    
    // properties
    var _id : String
    var nom : String
    var prenom : String
    var email : String
    var password : String
    var affectations : [Affectation]
    var isAdmin : Bool
    
    init(benevoleVM : BenevoleViewModel){
        self._id = benevoleVM._id
        self.nom = benevoleVM.nom
        self.prenom = benevoleVM.prenom
        self.email = benevoleVM.email
        self.password = benevoleVM.password
        self.affectations = benevoleVM.affectations
        self.isAdmin = benevoleVM.isAdmin
    }
    
    static func convertBenevoleDTOsToDisplay(benevolesDTOs : [BenevoleDTO]) -> [BenevoleViewModel]{
        var benevoleViewModelArray : [BenevoleViewModel] = []
        for benevoleDTO in benevolesDTOs {
            let benevoleViewModel = BenevoleViewModel(benevoleDTO: benevoleDTO)
            benevoleViewModelArray.append(benevoleViewModel)
        }
        return benevoleViewModelArray
    }
    
}
