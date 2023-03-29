//
//  ZoneState.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import SwiftUI
import Foundation

enum ZoneState : CustomStringConvertible, Equatable{
    case ready
    case error(ZoneIntentError)
    var description: String{return "description of ZoneState"}
}

