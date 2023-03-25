//
//  FestivalViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FakeFestivalViewModel: ObservableObject{
    
    // Observers: a list of view models
    var observers: [ViewModelObserver] = []
    
    // fake data
    @Published var festival: Festival {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    // fake data
    @Published var name: String {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    // fake data
    @Published var jourListViewModel: JourListViewModel
    // fake data
    @Published var zones: [Zone] {
        didSet {
            for observer in observers {
                observer.viewModelUpdated()
            }
        }
    }
    // fake data
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
            case .error:
                print("FestivalViewModel: error state")
            }
        }
    }

    // Constructor fake data
    init(festival: Festival) {
        self.festival = festival
        self.name = festival.name
        self.jourListViewModel = JourListViewModel(jours: festival.days)
        self.zones = festival.zones
        self.isActive = festival.isActive
    }
    
    func register(obs: ViewModelObserver) {
        self.observers.append(obs)
    }

    func updateFestivalName(name: String) {
        self.name = name
    }

    func addNewDay() {
        let newJours = self.jourListViewModel.addNewDay(jours: self.festival.days)
        self.festival.days = newJours
    }

    func addNewZone() {
        let newId = self.zones.count + 1
        let newZone = Zone(id: newId, name: "Nouvelle Zone", nbBenevolesMin: 0)
        self.zones.append(newZone)
    }
}
