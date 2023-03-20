//
//  AuthService.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

class AuthService {
    let api : String = "https://festivalappapi.onrender.com"
    let localhost : String = ""
    func login(email: String, password: String) async -> Result<String?, Error> {
        guard let url = URL(string: "https://festivalappapi.onrender.com/api/benevoles/login") else {
            return .failure(APIRequestError.unknown)
        }
        debugPrint(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginInfo: [String: Any] = ["nom" : "", "prenom" : "", "email": email, "password": password, "isAdmin" : false, "affectations" : []]
        //request.httpBody = try? JSONSerialization.data(withJSONObject: loginInfo)
        guard let encoded = try? JSONSerialization.data(withJSONObject: loginInfo) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from : encoded)
            debugPrint(response)
            let httpresponse = response as! HTTPURLResponse // le bon type
            debugPrint(httpresponse.statusCode)
            if httpresponse.statusCode == 200 || httpresponse.statusCode == 404 {
                debugPrint(data)
                guard let decoded : authData = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                AuthManager.saveAuthToken(decoded.token) // save the token of benevole
                AuthManager.saveBenevoleId(decoded.benevoleId) // save the id of the benevole
                debugPrint(decoded)
            }
        }catch{
            return .failure(APIRequestError.UploadError("AuthService login"))
        }
        return .success(AuthManager.getBenevoleId())
    }

    // Add other Benevole-related API calls here

    func logout(){
        AuthManager.clearAuthToken()
        AuthManager.clearBeneveoleId()
    }

}

