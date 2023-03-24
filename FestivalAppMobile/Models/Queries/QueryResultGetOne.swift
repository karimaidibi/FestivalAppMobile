//
//  QueryResultGetOne.swift
//  FestivalAppMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation


struct QueryResultGetOne<T: Decodable> : Decodable {
    
    //properties
    var status : Int
    var result : T
    
}
