//
//  CustomEditButton.swift
//  FestivalAppMobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation
import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        Button(action: {
            // Toggle between edit mode and normal mode
            withAnimation {
                self.editMode?.wrappedValue = self.editMode?.wrappedValue == .inactive ? .active : .inactive
            }
        }) {
            // Change the image based on the edit mode
            if editMode?.wrappedValue == .inactive {
                Image(systemName: "pencil")
            } else {
                Image(systemName: "checkmark")
            }
        }
    }
}
