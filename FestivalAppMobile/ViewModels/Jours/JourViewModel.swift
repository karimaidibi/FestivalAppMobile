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

    // State Intent management
    //@Published var state: JourState = .ready {
      //  didSet {
        //    switch state {
          //  case .ready:
            //    print("JourViewModel: ready state")
            //case .error:
              //  print("JourViewModel: error state")
           // }
       // }
   // }

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
