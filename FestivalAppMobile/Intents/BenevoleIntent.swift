//
//  BenevoleIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleIntent{
    @ObservedObject private var model : BenevoleViewModel
    private var benevoleService : BenevoleService = BenevoleService()
    
    init(benevole : BenevoleViewModel){
        self.model = benevole
    }
    

}
