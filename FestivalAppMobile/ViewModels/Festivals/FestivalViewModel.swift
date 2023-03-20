//
//  FestivalViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FestivalViewModel: ObservableObject {
    // Observers: a list of view models
    var observers: [ViewModelObserver] = []
    
    // Properties: will notify the model when the view changes any of these properties
    @Published var festival: Festival {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var name: String {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var days: [Jour] {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    
    @Published var isActive: Bool {
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
    init(festival: Festival) {
        self.festival = festival
        self.name = festival.name
        self.days = festival.days
        self.isActive = festival.isActive
    }
    
    // Functions
    func register(obs: ViewModelObserver) {
        self.observers.append(obs)
    }
    
    func updateFestivalName(name: String) {
        self.name = name
    }
    
    func addNewDay() {
        let newId = self.days.count + 1
        let newJour = Jour(id: newId, date: Date(), startingTime: "00:00", endingTime: "00:00", participantCount: 0, creneaux: [])
        self.days.append(newJour)
    }
}
