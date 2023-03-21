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
    private static let benevoleNameKey = "benevoleName"
    private static let isAdminKey = "isAdmin"

    
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
    
    // benevoleName management
    static func saveBenevoleName(_ name: String) {
        UserDefaults.standard.setValue(name, forKey: benevoleNameKey)
    }

    static func getBenevoleName() -> String? {
        return UserDefaults.standard.string(forKey: benevoleNameKey)
    }

    static func clearBenevoleName() {
        UserDefaults.standard.removeObject(forKey: benevoleNameKey)
    }

    // isAdmin management
    static func saveIsAdmin(_ isAdmin: Bool) {
        UserDefaults.standard.set(isAdmin, forKey: isAdminKey)
    }

    static func getIsAdmin() -> Bool {
        return UserDefaults.standard.bool(forKey: isAdminKey)
    }

    static func clearIsAdmin() {
        UserDefaults.standard.removeObject(forKey: isAdminKey)
    }

    
}
