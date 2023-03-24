//
//  CreneauxView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI

// fake data
let slots: [Slot] = [
    Slot(id: 1, StartingTime: "09:00 AM", EndingTime: "10:00 AM", zone: "Zone A"),
    Slot(id: 2, StartingTime: "11:00 AM", EndingTime: "12:00 PM", zone: "Zone B"),
    Slot(id: 3, StartingTime: "01:00 PM", EndingTime: "02:00 PM", zone: "Zone C"),
    Slot(id: 4, StartingTime: "03:00 PM", EndingTime: "04:00 PM", zone: "Zone D"),
]

struct CreneauxView: View {
    @State private var bookedSlots: [Slot] = []
    
    var body: some View {
        NavigationView{
            VStack {
                if bookedSlots.isEmpty {
                    Text("No booked time slots.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(bookedSlots) { slot in
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(slot.StartingTime)
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                Text(slot.EndingTime)
                                    .font(.headline)
                                Text(slot.zone)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                // Handle the delete action here by removing the `Slot` from the list
                                // You can use an alert or a confirmation sheet to ask the user to confirm the delete action
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)                       }
                }
            }
            .onAppear {
                // Fetch the user's booked time slots from your API and update the `bookedSlots` variable
                // You can use an async/await pattern or Combine to handle the API call and response
                bookedSlots = slots
            }
            .navigationTitle("Mes créneaux")
            .navigationBarTitleDisplayMode(.inline)
            .font(.system(size: 18))
        }
    }
}

struct CardView: View {
    var slot: Slot
    
    var body: some View {
        VStack {
            Text(slot.StartingTime)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            Text(slot.EndingTime)
                .font(.headline)
                .padding(.bottom, 10)
            
            Text(slot.zone)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct Slot: Identifiable {
    let id: Int
    let StartingTime: String
    let EndingTime: String
    let zone: String
}
