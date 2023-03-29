//
//  ZoneIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation
import SwiftUI

struct ZoneIntent{
    @ObservedObject private var model : ZoneViewModel
    
    init(zone : ZoneViewModel){
        self.model = zone
    }
}
