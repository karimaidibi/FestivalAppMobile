//
//  EnvironmentHelper.swift
//  FestivalAppMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation

import Foundation

class EnvironmentHelper {
    static func getEnvironmentValue(forKey key: String) -> String? {
        guard let plist = Bundle.main.path(forResource: "Environment", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: plist) as? [String: AnyObject]
        else {
            return nil
        }
        return dict[key] as? String
    }
}
