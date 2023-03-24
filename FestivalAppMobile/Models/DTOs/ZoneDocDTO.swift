//
//  ZoneDocDTO.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

class ZoneDocDTO : Decodable, Encodable, Hashable {
    
    // properties
    var _id : String
    var nom : String
    var benevoles_necessaires : Int
    var idFestival : FestivalDTO
    
    // functions
    static func == (lhs: ZoneDocDTO, rhs: ZoneDocDTO) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
    
}
