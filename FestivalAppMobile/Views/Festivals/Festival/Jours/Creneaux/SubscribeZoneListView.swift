//
//  CreneauView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct SubscribeZoneListView: View {
    @ObservedObject var creneauVM : CreneauViewModel
    @ObservedObject var zonesVM : ZoneListViewModel
    @StateObject var authManager : AuthManager = AuthManager()
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    //let isUserAdmin: Bool = false
    //@State private var selectedZone: Zone?
    
    var body: some View{
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        Section(header: Text("Choisissez une zone pour s'inscrire")) {
            List{
                ForEach(zonesVM, id:\.self) { zoneVM in
                        //NavigationLink(destination: ZoneView(viewModel: zoneVM)) {
                    SubscribeZoneRowView(zoneVM: zoneVM, creneauVM : creneauVM, benevoleVM: benevoleVM)
                        //}
                    }
            }
        }
        .task {
            if let benevoleId = authManager.benevoleId{
                let benevoleLoaded = await benevoleIntent.getBenevoleById(benevoleId: benevoleId)
                if !benevoleLoaded{
                    alertMessage = benevoleVM.errorMessage
                    alertTitle = "Error"
                    showAlert = true
                }
            }
        }

    }

}


//var body: some View {
    //EmptyView()
    // get les zones du festival à partir du viewModel du festival
    //List(festivalVM.zoneListViewModels) { zoneVM in
        //Button(action: {
            //if isUserAdmin {
                //selectedZone = zone
            //} else {
                //benevoleVM.subscribeToZone(zone: zone)
            //}
        //}) {
          //  ZoneView(zone: zone)
        //}
        //.buttonStyle(PlainButtonStyle())
        //.navigationLink(isActive: $selectedZone) {
          //  SubscribeBenevolesView(zone: selectedZone!)
        //} label: {
            //EmptyView()
        //}
    //}
    //.navigationBarTitle("Choisissez une zone pour s'inscrire")
//}
