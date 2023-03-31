//
//  CreneauView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct CreneauView: View {
    var viewModel : CreneauViewModel
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    @StateObject var authManager : AuthManager = AuthManager()
    let isUserAdmin: Bool = false
    @State private var selectedZone: Zone?
    
    var body: some View {
        EmptyView()
        // get les zones du festival à partir du viewModel du creneau
        // areas = getFestivalZones(viewModel.idJour.idFestival)
        //List(areas) { zone in
            //Button(action: {
                //if isUserAdmin {
                    //selectedZone = zone
                //} else {
                    //benevoleVM.subscribeToZone(zone: zone)
                //}
            //}) {
                //ZoneView(zone: zone)
            //}
            //.buttonStyle(PlainButtonStyle())
            //.navigationLink(isActive: $selectedZone) {
                //SubscribeBenevolesView(zone: selectedZone!)
            //} label: {
                //EmptyView()
            //}
        //}
        //.navigationBarTitle("Choisissez une zone pour s'inscrire")
    }
}

