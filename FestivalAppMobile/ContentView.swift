//
//  ContentView.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//


import SwiftUI

let fakeFestivals = [
    Festival(id: 1, name: "Festival de Nîmes", days: [
        Jour(id: 1, date: Date(), startingTime: "9:00 AM", endingTime: "12:00 PM", participantCount: 50, creneaux: [
            Creneau(id: 1, startingTime: "9:00 AM", endingTime: "10:00 AM", area: "Esplanade Gauche 1"),
            Creneau(id: 2, startingTime: "10:00 AM", endingTime: "11:00 AM", area: "Esplanade Gauche 1"),
            Creneau(id: 3, startingTime: "11:00 AM", endingTime: "12:00 PM", area: "Esplanade Gauche 1")
        ]),
        Jour(id: 2, date: Date().addingTimeInterval(86400), startingTime: "10:00 AM", endingTime: "2:00 PM", participantCount: 75, creneaux: [
            Creneau(id: 4, startingTime: "10:00 AM", endingTime: "11:00 AM", area: "Antigone Buvette"),
            Creneau(id: 5, startingTime: "11:00 AM", endingTime: "12:00 PM", area: "Antigone Buvette"),
            Creneau(id: 6, startingTime: "1:00 PM", endingTime: "2:00 PM", area: "Antigone Buvette")
        ]),
        Jour(id: 3, date: Date().addingTimeInterval(86400 * 2), startingTime: "11:00 AM", endingTime: "1:00 PM", participantCount: 60, creneaux: [
            Creneau(id: 7, startingTime: "11:00 AM", endingTime: "12:00 PM", area: "Libre"),
            Creneau(id: 8, startingTime: "12:00 PM", endingTime: "1:00 PM", area: "Libre")
        ])
    ], isActive: true),
    Festival(id: 2, name: "Festival de Sète", days: [
           Jour(id: 1, date: Date(), startingTime: "10:00 AM", endingTime: "12:00 PM", participantCount: 40, creneaux: [
               Creneau(id: 1, startingTime: "10:00 AM", endingTime: "11:00 AM", area: "Libre"),
               Creneau(id: 2, startingTime: "11:00 AM", endingTime: "12:00 PM", area: "Libre")
           ]),
           Jour(id: 2, date: Date().addingTimeInterval(86400), startingTime: "11:00 AM", endingTime: "2:00 PM", participantCount: 60, creneaux: [
               Creneau(id: 3, startingTime: "11:00 AM", endingTime: "12:00 PM", area: "Libre"),
               Creneau(id: 4, startingTime: "12:00 PM", endingTime: "1:00 PM", area: "Libre"),
               Creneau(id: 5, startingTime: "1:00 PM", endingTime: "2:00 PM", area: "Libre")
           ]),
           Jour(id: 3, date: Date().addingTimeInterval(86400 * 2), startingTime: "12:00 PM", endingTime: "1:00 PM", participantCount: 50, creneaux: [])], isActive: false)
]

struct ContentView: View {
    @State var land: Bool = true
    @State var visitor : Bool = false
        
    var body: some View {
        NavigationView {
           if land {
               LandingPageView(land: $land)
           } else {
               MenuView(selection: .home, visitor: visitor)
           }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
