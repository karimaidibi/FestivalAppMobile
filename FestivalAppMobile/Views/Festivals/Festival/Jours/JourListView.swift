//
//  JourListView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

struct JourListView : View {
    
    
    @ObservedObject var joursVM : JourListViewModel
    @ObservedObject var festivalVM : FestivalViewModel
    @ObservedObject var benevolesVM : BenevoleListViewModel
    @StateObject var authManager : AuthManager = AuthManager()
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View{
        
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        Section(header: customHeaderView()) {
            if joursVM.loading{
                ProgressView("Loading Jours ...")
            }else{
                ForEach(joursVM, id:\.self) { jourVM in
                    NavigationLink(destination: JourView(viewModel: jourVM, festivalVM: festivalVM)) {
                        JourRowView(jourVM: jourVM,  benevolesVM: benevolesVM)
                    }
                }
                .onDelete { indexSet in
                    Task {
                        let jour = joursVM[indexSet.first!]
                        let jourDeleted = await joursIntent.removeJour(id: jour._id)
                        if jourDeleted{
                            joursVM.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
        }
    }
    
    private func customHeaderView() -> some View {
        HStack {
            Text("Jours")
            if let isAdmin = authManager.isAdmin{
                if isAdmin{
                    Spacer()
                    // envoie le user vers la page de création du jour
                    NavigationLink(destination: AddJourView(joursVM: joursVM, festivalVM: festivalVM)) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing, 1)
                    CustomEditButton()
                }
            }
        }
    }
}
