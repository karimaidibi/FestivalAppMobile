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

    static func dateFromString(_ dateString: String, dateFormat: String = "yyyy-MM-dd") -> Date? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = dateFormat
          return dateFormatter.date(from: dateString)
      }
    
    public var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
}
