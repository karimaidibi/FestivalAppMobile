//
//  CreneauListView.swift
//  FestivalAppMobile
//
//  Created by m1 on 30/03/2023.
//

import Foundation
import SwiftUI

struct CreneauListView : View{
    @ObservedObject var jourVM : JourViewModel
    @StateObject var creneauxVM : CreneauListViewModel = CreneauListViewModel(creneauViewModelArray: [])
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View{
        
        let creneauListIntent : CreneauListIntent = CreneauListIntent(viewModel: creneauxVM)
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(creneauxVM) { creneauVM in
                    Divider() // comme sur angular mat
                    CreneauRowView(creneauVM: creneauVM)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            let creneauxLoaded = await creneauListIntent.getCreneauxByJour(jourId: jourVM._id)
            if !creneauxLoaded{
                // afficher erreur popup
                alertMessage = creneauxVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }
        }
        
    }
    
    
}
