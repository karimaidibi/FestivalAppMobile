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
    
    @Published var affectations : [AffectationDTO]{
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
    
    // this message is to display in the view e.g popup or snackbar
    @Published var authErrorMessage : String = ""
    
    @Published var signUpSucessMessage : String = ""
    
    // to call in the view when loading
    @Published var loading : Bool = false
    
    // State Intent management
    @Published var state : BenevoleState = .ready{
        didSet{
            switch state{
            case .ready:
                debugPrint("BenevoleViewModel : ready state")
                debugPrint("-------------------------------")
                self.loading = false
                self.authErrorMessage = ""
            case .loading:
                debugPrint("BenevoleViewModel : loading state")
                debugPrint("-------------------------------")
                self.loading = true
                self.authErrorMessage = ""
            case .loggedOut:
                debugPrint("BenevoleViewModel : loggedOut state")
                debugPrint("-------------------------------")
                self.loading = false
                self.authErrorMessage = ""
            case .loggedIn(let benevoleDTO):
                debugPrint("BenevoleViewModel : loggedIn state")
                debugPrint("-------------------------------")
                self._id = benevoleDTO._id
                self.nom = benevoleDTO.nom
                self.prenom = benevoleDTO.prenom
                self.email = benevoleDTO.email
                self.password = benevoleDTO.password
                self.affectations = benevoleDTO.affectations
                self.isAdmin = benevoleDTO.isAdmin
                self.loading = false
                self.authErrorMessage = ""
            case .tooShortPassword:
                debugPrint("BenevoleViewModel : tooShortPassword state")
                debugPrint("-------------------------------")
                self.authErrorMessage = state.description
                self.loading = false
            case .emailNotValid:
                debugPrint("BenevoleViewModel : emailNotValid state")
                debugPrint("-------------------------------")
                self.authErrorMessage = state.description
                self.loading = false
            case .error:
                debugPrint("BenevoleViewModel : error state")
                debugPrint("-------------------------------")
                self.loading = false
            case .signedUp(let msg):
                debugPrint("BenevoleViewModel : signedUp state")
                debugPrint("-------------------------------")
                self.signUpSucessMessage = msg
                self.loading = false
            case .authFailed(_):
                debugPrint("BenevoleViewModel : authFailed state")
                debugPrint("-------------------------------")
                self.authErrorMessage = state.description
                self.loading = false
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
