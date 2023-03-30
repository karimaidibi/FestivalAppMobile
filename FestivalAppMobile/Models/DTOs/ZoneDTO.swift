//
//  ZoneDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//

import Foundation
import SwiftUI

class ZoneDTO : Decodable, Encodable, Equatable, Identifiable {
    // properties
    var _id : String
    var nom : String
    var nombre_benevoles_necessaires : Int
    var idFestival : String
    
    init(nom : String, nombre_benevoles_necessaires : Int, idFestival : String){
        self.nom = nom
        self.nombre_benevoles_necessaires = nombre_benevoles_necessaires
        self.idFestival = idFestival
        self._id = ""
    }
    
    init(zoneVM : ZoneViewModel){
        self._id = zoneVM._id
        self.nom = zoneVM.nom
        self.nombre_benevoles_necessaires = zoneVM.nombre_benevoles_necessaires
        self.idFestival = zoneVM.idFestival
    }
    
    static func convertZoneDTOsToDisplay(zoneDTOs : [ZoneDTO]) -> [ZoneViewModel]{
        var zoneViewModelArray : [ZoneViewModel] = []
        for zoneDTO in zoneDTOs {
            let zoneViewModel = ZoneViewModel(zoneDTO: zoneDTO)
            zoneViewModelArray.append(zoneViewModel)
        }
        return zoneViewModelArray
    }
    
    static func == (lhs: ZoneDTO, rhs: ZoneDTO) -> Bool {
        return lhs._id == rhs._id
    }
}
