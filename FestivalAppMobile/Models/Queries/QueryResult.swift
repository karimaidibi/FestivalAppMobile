//
//  QueryResult.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//

import Foundation

struct QueryResult<T: Decodable> : Decodable {
    
    //properties
    var status : Int
    var result : [T]
    
}
