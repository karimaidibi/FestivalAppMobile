//
//  FestivalViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FestivalViewModel: ObservableObject, Hashable {
    
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

    // State Intent management
    @Published var state: FestivalState = .ready {
        didSet {
            switch state {
            case .ready:
                print("FestivalViewModel: ready state")
            case .error:
                print("FestivalViewModel: error state")
            }
        }
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
