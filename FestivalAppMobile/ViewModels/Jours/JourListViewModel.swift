//
//  JourListViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 23/03/2023.
//

import Foundation

class JourListViewModel : ObservableObject {
    // The model views array
   @Published var jourViewModels: [JourViewModel] = []
   
   init(jours: [Jour]) {
       self.jourViewModels = jours.map { JourViewModel(jour: $0) }
   }
   
    func addNewDay(jours : [Jour]) -> [Jour] {
        var newJours = jours
        let newJour = Jour(id: newJours.count, date: Date(), startingTime: "00:00", endingTime: "00:00", participantCount: 0, creneaux: [])
        newJours.append(newJour)
        self.jourViewModels.append(JourViewModel(jour: newJour))
        return newJours
    }
   
   func getJourViewModel(for jour: Jour) -> JourViewModel? {
       return jourViewModels.first { $0.jour.id == jour.id }
   }
    
}
