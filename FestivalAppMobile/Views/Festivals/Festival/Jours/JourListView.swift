//
//  JourListView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

struct JourListView : View {
    
    
    @StateObject var joursVM : JourListViewModel = JourListViewModel(jourViewModels : [])
    @ObservedObject var festivalVM : FestivalViewModel
    
    var body: some View{
        
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        Section(header: Text("Jours")) {
                ForEach(joursVM, id:\.self) { jourVM in
                    //NavigationLink(destination: JourFestivalView(viewModel: jourVM)) {
                        JourRowView(jourVM: jourVM)
                    //}
                }
        }
        .task {
            let joursLoaded = await joursIntent.getJoursByFestival(festivalId: festivalVM._id)
        }
        
        
    }
    
    
}
