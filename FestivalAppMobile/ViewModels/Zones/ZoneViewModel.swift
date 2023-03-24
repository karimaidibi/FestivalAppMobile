//
//  ZoneViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation;
import SwiftUI

class ZoneViewModel : ObservableObject, Hashable{
        
    //observers : lists of view model
    var observers : [ViewModelObserver] = []
    
    //Properties : will notify the model when the view change any of these properties
    @Published var _id : String
    
    //Properties : will notify the model when the view change any of these properties
    @Published var nom : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    // State Intent management
    @Published var state : ZoneState = .ready{
        didSet{
            switch state{
            case .ready:
                debugPrint("ZoneViewModel : ready state")
                debugPrint("-------------------------------")
            default:
                break
            }
        }
    }
    
    // constructor
    init(zoneDTO : ZoneDTO){
        self._id = zoneDTO._id
        self.nom = zoneDTO.nom
    }
    
    // functions
    static func == (lhs: ZoneViewModel, rhs: ZoneViewModel) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
}
