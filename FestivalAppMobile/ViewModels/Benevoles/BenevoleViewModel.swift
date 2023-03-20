//
//  BenevoleViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation

class BenevoleViewModel : ObservableObject, Hashable{
        
    //observers : lists of view model
    var observers : [ViewModelObserver] = []
    
    //Properties : will notify the observers when any of these properties changes
    
    @Published var _id : String
    
    @Published var nom : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }

    @Published var prenom : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var email : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var password : String{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var affectations : [Affectation]{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    @Published var isAdmin : Bool{
        didSet{
            for o in self.observers{
                o.viewModelUpdated()
            }
        }
    }
    
    // State Intent management
    @Published var state : BenevoleState = .ready{
        didSet{
            switch state{
            case .ready:
                debugPrint("BenevoleViewModel : ready state")
                debugPrint("-------------------------------")
            default:
                break
            }
        }
    }
    
    // constructor
    init(benevoleDTO : BenevoleDTO){
        self._id = benevoleDTO._id
        self.nom = benevoleDTO.nom
        self.prenom = benevoleDTO.prenom
        self.email = benevoleDTO.email
        self.password = benevoleDTO.password
        self.affectations = benevoleDTO.affectations
        self.isAdmin = benevoleDTO.isAdmin
    }
    
    init(){
        self._id = ""
        self.nom = ""
        self.prenom = ""
        self.email = ""
        self.password = ""
        self.affectations = []
        self.isAdmin = false
    }
    
    // functions
    static func == (lhs: BenevoleViewModel, rhs: BenevoleViewModel) -> Bool{
        return lhs._id == rhs._id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self._id)
    }
    
    func register(obs: ViewModelObserver){
        self.observers.append(obs)
    }
    
}
