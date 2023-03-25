//
//  FestivalsViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FakeFestivalsViewModel : ObservableObject {
    
    // The model views array
   @Published var festivalViewModels: [FakeFestivalViewModel] = []
   
    // init fake data to be removed
   init(festivals: [Festival]) {
       self.festivalViewModels = festivals.map { FakeFestivalViewModel(festival: $0) }
   }
    
    
    // functions that update this listt view model when the view model is changed
    func viewModelUpdated(){
        self.objectWillChange.send()
    }

    
   // fake data function
   func addNewFestival(festivals: [Festival]) -> [Festival] {
       var newFestivals = festivals
       let zoneLibre = Zone(id: 0, name: "Libre", nbBenevolesMin : 0)
       let newFestival = Festival(id: newFestivals.count, name: "New Festival", days: [], zones: [zoneLibre] ,isActive: false)
       newFestivals.append(newFestival)
       self.festivalViewModels.append(FakeFestivalViewModel(festival: newFestival))
       return newFestivals
   }
   
    // fake data function
   func getFestivalViewModel(for festival: Festival) -> FakeFestivalViewModel? {
       return festivalViewModels.first { $0.festival.id == festival.id }
   }
    
}
