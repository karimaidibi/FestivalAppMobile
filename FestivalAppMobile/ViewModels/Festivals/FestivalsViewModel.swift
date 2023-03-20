//
//  FestivalsViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FestivalsViewModel : ObservableObject {
    func addNewFestival(festivals: [Festival]) -> [Festival] {
        var newFestival = Festival(id: festivals.count + 1, name: "New Festival", days: [], isActive: false)
        var newFestivals = festivals
        newFestivals.append(newFestival)
        return newFestivals
    }
    
    func addNewDay(jour: Jour, festival: Festival) -> Festival {
        var updatedFestival = festival
        var updatedDays = updatedFestival.days
        let newId = updatedDays.count + 1
        let newJour = Jour(id: newId, date: Date(), startingTime: "00:00", endingTime: "00:00", participantCount: 0, creneaux: [])
        updatedDays.append(newJour)
        updatedFestival.days = updatedDays
        return updatedFestival
    }
}
