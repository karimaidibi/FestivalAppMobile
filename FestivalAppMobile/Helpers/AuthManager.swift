//
//  AuthManager.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

class AuthManager {
    private static let tokenKey = "authToken"
    private static let benevoleIdKey = "benevoleId"
    
    // auth token management
    static func saveAuthToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: tokenKey)
    }

    static func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }

    static func clearAuthToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    // benevole id logged in management
    static func saveBenevoleId(_ benevole: String) {
        UserDefaults.standard.setValue(benevole, forKey: benevoleIdKey)
    }

    static func getBenevoleId() -> String? {
        return UserDefaults.standard.string(forKey: benevoleIdKey)
    }

    static func clearBeneveoleId() {
        UserDefaults.standard.removeObject(forKey: benevoleIdKey)
    }
    
}
