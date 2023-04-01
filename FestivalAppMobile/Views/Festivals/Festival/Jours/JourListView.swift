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
    @ObservedObject var benevolesVM : BenevoleListViewModel
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View{
        
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        Section(header: Text("Jours")) {
            if joursVM.loading{
                ProgressView("Loading Jours ...")
            }else{
                ForEach(joursVM, id:\.self) { jourVM in
                    NavigationLink(destination: JourView(viewModel: jourVM, festivalVM: festivalVM)) {
                        JourRowView(jourVM: jourVM,  benevolesVM: benevolesVM)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            let joursLoaded = await joursIntent.getJoursByFestival(festivalId: festivalVM._id)
            if !joursLoaded{
                alertMessage = joursVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }
        }
        
        
    }
    
    
}
