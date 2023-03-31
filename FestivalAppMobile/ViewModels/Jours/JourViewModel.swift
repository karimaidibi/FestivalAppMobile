//
//  JourViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 23/03/2023.
//

import Foundation

class JourViewModel: ObservableObject, Hashable, Identifiable {
    
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
    @Published var date : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    //Properties : will notify the model when the view change any of these properties
    @Published var heure_ouverture : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    @Published var heure_fermeture : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }

    @Published var idFestival : String
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    @Published var successMessage : String = ""

    //State Intent management
    @Published var state: JourState = .ready {
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
            case .jourUpdated(let jourDTO):
                print(state.description)
                debugPrint("-------------------------------")
                self.updateJour(jourDTO: jourDTO)
                self.loading = false
                self.successMessage = "Jour Updated Successfully !"
            case .jourUpdatingFailed(let error):
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = error.localizedDescription
            case .error:
                print("JourViewModel: error state")
            }
        }
   }
    
    private func updateJour(jourDTO : JourDTO){
        self.date = jourDTO.date
        self.nom = jourDTO.nom
        self.heure_ouverture = jourDTO.heure_ouverture
        self.heure_fermeture = jourDTO.heure_fermeture
        self.idFestival = jourDTO.idFestival
    }

    // constructor
    init(jourDTO : JourDTO){
        self._id = jourDTO._id
        self.nom = jourDTO.nom
        self.date = jourDTO.date
        self.heure_ouverture = jourDTO.heure_ouverture
        self.heure_fermeture = jourDTO.heure_fermeture
        self.idFestival = jourDTO.idFestival
    }
    

    // Functions
    static func == (lhs: JourViewModel, rhs: JourViewModel) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
    
    func register(obs: ViewModelObserver) {
        self.observers.append(obs)
    }

}
