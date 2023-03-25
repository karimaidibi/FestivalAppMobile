//
//  ZoneDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//

import Foundation
import SwiftUI

class ZoneDTO : Decodable, Encodable {
    
    // properties
    var _id : String
    var nom : String
    var nombre_benevoles_necessaires : Int
    var idFestival : String
    
    static func convertZoneDTOsToDisplay(zoneDTOs : [ZoneDTO]) -> [ZoneViewModel]{
        var zoneViewModelArray : [ZoneViewModel] = []
        for zoneDTO in zoneDTOs {
            let zoneViewModel = ZoneViewModel(zoneDTO: zoneDTO)
            zoneViewModelArray.append(zoneViewModel)
        }
        return zoneViewModelArray
    }
}
