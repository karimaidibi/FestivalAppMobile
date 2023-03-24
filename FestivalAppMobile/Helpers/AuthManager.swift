//
//  AuthManager.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

class AuthManager : ObservableObject{
    private let tokenKey = "authToken"
    private let benevoleIdKey = "benevoleId"
    private let isAdminKey = "isAdmin"

    init() {
        authToken = UserDefaults.standard.string(forKey: tokenKey) //getAuthToken()
        isAdmin =   UserDefaults.standard.bool(forKey: isAdminKey) //getIsAdmin()
        benevoleId = UserDefaults.standard.string(forKey: benevoleIdKey)  //getBenevoleId()
    }
    
    @Published var authToken: String?{
        didSet{
            if let token = authToken {
                self.saveAuthToken(token)
            }else{
                self.clearAuthToken()
            }
        }
    }
    
    @Published var isAdmin: Bool?{
        didSet{
            if let bool = isAdmin{
                self.saveIsAdmin(bool)
            }else{
                self.clearIsAdmin()
            }
        }
    }
    
    @Published var benevoleId: String?{
        didSet{
            if let id = benevoleId{
                self.saveBenevoleId(id)
            }else{
                self.clearBeneveoleId()
            }
        }
    }

    
    // auth token management
    func saveAuthToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: tokenKey)
    }

    func clearAuthToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    // benevole id logged in management
    func saveBenevoleId(_ benevole: String) {
        UserDefaults.standard.setValue(benevole, forKey: benevoleIdKey)
    }

    func clearBeneveoleId() {
        UserDefaults.standard.removeObject(forKey: benevoleIdKey)
    }
    
    // isAdmin management
    func saveIsAdmin(_ isAdmin: Bool) {
        UserDefaults.standard.set(isAdmin, forKey: isAdminKey)
    }

    func clearIsAdmin() {
        UserDefaults.standard.removeObject(forKey: isAdminKey)
    }

    
}
