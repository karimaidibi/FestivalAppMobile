//
//  FestivalDTO.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

import SwiftUI

class FestivalDTO : Decodable, Encodable {
    
    // properties
    var _id : String
    var nom : String
    
    static func convertZoneDTOsToDisplay(zoneDTOs : [ZoneDTO]) -> [ZoneViewModel]{
        var zoneViewModelArray : [ZoneViewModel] = []
        for zoneDTO in zoneDTOs {
            let zoneViewModel = ZoneViewModel(zoneDTO: zoneDTO)
            zoneViewModelArray.append(zoneViewModel)
        }
        return zoneViewModelArray
    }
}
