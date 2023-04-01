//
//  FestivalViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FestivalViewModel: ObservableObject, Hashable, Identifiable {
    
    // Observers: a list of view models
    var observers: [ViewModelObserver] = []

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
    
    //Properties : will notify the model when the view change any of these properties
    @Published var annee : Int{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    //Properties : will notify the model when the view change any of these properties
    @Published var estCloture : Bool{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var nbre_benevoles_necessaires = 0
    
    @Published var zoneListViewModels : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: []){
        didSet{
            self.nbre_benevoles_necessaires = zoneListViewModels.zoneViewModelArray.reduce(0) { sum, zone in
                sum + zone.nombre_benevoles_necessaires
            }
        }
    }
    
    @Published var jourListViewModels : JourListViewModel = JourListViewModel(jourViewModels: [])
    @Published var benevolesVMOfFestival :  BenevoleListViewModel = BenevoleListViewModel(benevoleViewModels: [])
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    @Published var successMessage : String = ""

    // State Intent management
    @Published var state: FestivalState = .ready {
        didSet {
            switch state {
            case .ready:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = ""
                self.successMessage = ""
            case .loading:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = true
            case .festivalUpdated(let festivalDTO):
                print(state.description)
                debugPrint("-------------------------------")
                self.updateFestival(festivalDTO: festivalDTO)
                self.loading = false
                self.successMessage = "Festival Updated Successfully !"
            case .benevolesDocUpdated:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
            case .festivalUpdatingFailed(let error):
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = error.localizedDescription
            case .error:
                print(state.description)
            }
        }
    }
    
    private func updateFestival(festivalDTO : FestivalDTO){
        self.nom = festivalDTO.nom
        self.annee = festivalDTO.annee
        self.estCloture = festivalDTO.estCloture
    }
    

    // constructor
    init(festivalDTO : FestivalDTO){
        self._id = festivalDTO._id
        self.nom = festivalDTO.nom
        self.annee = festivalDTO.annee
        self.estCloture = festivalDTO.estCloture
    }
    

    // Functions
    static func == (lhs: FestivalViewModel, rhs: FestivalViewModel) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
    
    func register(obs: ViewModelObserver) {
        self.observers.append(obs)
    }

}
