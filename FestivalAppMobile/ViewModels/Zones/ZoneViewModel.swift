//
//  ZoneViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation;
import SwiftUI

class ZoneViewModel : ObservableObject, Hashable, Identifiable{
    //observers : lists of view model
    var observers : [ViewModelObserver] = []
    
    //Properties : will notify the model when the view change any of these properties
    @Published var _id : String
    
    @Published var nom : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var nombre_benevoles_necessaires : Int{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var idFestival : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var nbre_benevoles_inscrits : Int = 0
    
    // State Intent management
    @Published var state : ZoneState = .ready{
        didSet{
            switch state{
            case .ready:
                debugPrint("ZoneViewModel : ready state")
                debugPrint("-------------------------------")
                self.loading = false
                self.successMessage = ""
                self.errorMessage = ""
            case .loading:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = true
            case .zoneUpdated(let zoneDTO):
                print(state.description)
                debugPrint("-------------------------------")
                self.updateZone(zoneDTO: zoneDTO)
                self.loading = false
                self.successMessage = "Zone Updated Successfully !"
            case .zoneUpdatingFailed(let error):
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = error.description
            case .zoneBenevolesInscritsComputed(let nbreBenevolesInscrits):
                print(state.description)
                debugPrint("-------------------------------")
                self.nbre_benevoles_inscrits = nbreBenevolesInscrits
                self.loading = false
            case .error:
                self.errorMessage = "error"
                self.loading = false
            }
        }
    }
    
    @Published var zoneListViewModels : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    @Published var successMessage : String = ""
    
    // constructor
    init(zoneDTO : ZoneDTO){
        self._id = zoneDTO._id
        self.nom = zoneDTO.nom
        self.nombre_benevoles_necessaires = zoneDTO.nombre_benevoles_necessaires
        self.idFestival = zoneDTO.idFestival
    }
    
    private func updateZone(zoneDTO : ZoneDTO){
        self.nom = zoneDTO.nom
        self.nombre_benevoles_necessaires = zoneDTO.nombre_benevoles_necessaires
        self.idFestival = zoneDTO.idFestival
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
