//
//  JourViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 23/03/2023.
//

import Foundation

class JourViewModel: ObservableObject, Identifiable {
    // Observers: a list of view models
    var observers: [ViewModelObserver] = []

    // Properties: will notify the model when the view changes any of these properties
    @Published var jour: Jour {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var date: Date {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var startingTime: String {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var endingTime: String {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var participantCount: Int {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var creneaux: [Creneau] {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    
    // State Intent management
    @Published var state: FestivalState = .ready {
        didSet {
            switch state {
            case .ready:
                print("FestivalViewModel: ready state")
            case .error(let error):
                print("FestivalViewModel: error state with error \(error.localizedDescription)")
            }
        }
    }
    
    // Constructor
    init(jour: Jour) {
        self.jour = jour
        self.date = jour.date
        self.startingTime = jour.startingTime
        self.endingTime = jour.endingTime
        self.participantCount = jour.participantCount
        self.creneaux = jour.creneaux
    }
    
    // Functions
    func register(obs: ViewModelObserver) {
        self.observers.append(obs)
    }
    
    func addNewCreneau() {
        let newId = self.creneaux.count + 1
        let zoneLibre = Zone(id: 0, name: "Libre", nbBenevolesMin : 0)
        let newCreneau = Creneau(id: newId, startingTime: "00:00", endingTime: "00:00", areas: [zoneLibre])
        self.creneaux.append(newCreneau)
        self.jour.creneaux.append(newCreneau)
    }

}
