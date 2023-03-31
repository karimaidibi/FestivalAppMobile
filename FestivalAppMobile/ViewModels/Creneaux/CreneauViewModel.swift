//
//  CreneauViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

import SwiftUI

class CreneauViewModel : ObservableObject, Hashable, Identifiable{
        
    //observers : lists of view model
    var observers : [ViewModelObserver] = []
    
    //Properties : will notify the model when the view change any of these properties
    @Published var _id : String
    
    //Properties : will notify the model when the view change any of these properties
    @Published var heure_debut : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    //Properties : will notify the model when the view change any of these properties
    @Published var heure_fin : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var idJour : String

    
    // State Intent management
    @Published var state : ZoneState = .ready{
        didSet{
            switch state{
            case .ready:
                debugPrint("CreneauViewModel : ready state")
                debugPrint("-------------------------------")
            default:
                break
            }
        }
    }
    
    // constructor
    init(_id: String, heure_debut: String, heure_fin: String, idJour : String){
        self._id = _id
        self.heure_fin = heure_fin
        self.heure_debut = heure_debut
        self.idJour = idJour
    }
    
    // constructor from DTO
    init(creneauDTO : CreneauDTO){
        self._id = creneauDTO._id
        self.heure_debut = creneauDTO.heure_debut
        self.heure_fin = creneauDTO.heure_fin
        self.idJour = creneauDTO.idJour
    }
    
    // functions
    static func == (lhs: CreneauViewModel, rhs: CreneauViewModel) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
}
