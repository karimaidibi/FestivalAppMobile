//
//  UtilityHelper.swift
//  FestivalAppMobile
//
//  Created by m1 on 30/03/2023.
//

import Foundation
import Combine
import SwiftUI

struct UtilityHelper{
    static func formattedDateString(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM yyyy"
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }

}
