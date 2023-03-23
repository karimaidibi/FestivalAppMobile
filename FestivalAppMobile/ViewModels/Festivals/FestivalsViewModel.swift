//
//  FestivalsViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FestivalsViewModel : ObservableObject {
    // The model views array
   @Published var festivalViewModels: [FestivalViewModel] = []
   
   init(festivals: [Festival]) {
       self.festivalViewModels = festivals.map { FestivalViewModel(festival: $0) }
   }
   
   func addNewFestival(festivals: [Festival]) -> [Festival] {
       var newFestivals = festivals
       let zoneLibre = Zone(id: 0, name: "Libre", nbBenevolesMin : 0)
       let newFestival = Festival(id: newFestivals.count, name: "New Festival", days: [], zones: [zoneLibre] ,isActive: false)
       newFestivals.append(newFestival)
       self.festivalViewModels.append(FestivalViewModel(festival: newFestival))
       return newFestivals
   }
   
   func getFestivalViewModel(for festival: Festival) -> FestivalViewModel? {
       return festivalViewModels.first { $0.festival.id == festival.id }
   }
    
}
