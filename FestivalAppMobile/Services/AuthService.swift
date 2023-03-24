//
//  AuthService.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

class AuthService {
    
    var api : String
    var benevolesService : BenevoleService = BenevoleService()
    var authManager : AuthManager
    
    init(authManager : AuthManager){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
        self.authManager = authManager
    }
    
    // login function
    func login(email: String, password: String) async -> Result<BenevoleDTO?, Error> {

        guard let url = URL(string: "\(self.api)/benevoles/login") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        let loginInfo: LogInDTO =  LogInDTO(email: email, password: password)
        guard let encoded : Data = await JSONHelper.encode(data: loginInfo) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        // send the request
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpresponse = response as! HTTPURLResponse // le bon type
            // si tout se passe bien
            if httpresponse.statusCode == 200{
                // recuperer query result
                guard let decoded : authData = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                let getBenevoleByIdResult = await self.benevolesService.getBenevoleById(id: decoded.benevoleId)
                switch getBenevoleByIdResult{
                	case .success(let benevoleDTO):
                    	// save the auth data
                        DispatchQueue.main.async {
                            self.authManager.authToken = decoded.token // save the token of benevole
                            self.authManager.benevoleId = decoded.benevoleId // save the id of the benevole
                            self.authManager.isAdmin = benevoleDTO.isAdmin
                    	}
                    return .success(benevoleDTO)
                    case .failure(let error):
                        return .failure(error)
                }
            }
            // sinon afficher erreur avec le status code
            else {
                // sinon recuperer query bad result
                guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                // si bad result
                let loginError : AuthError = AuthError(message: queryBadResult.message)
                debugPrint(APIRequestError.UploadError("Bad Result In LogIn, code: \(queryBadResult.status), message : \(queryBadResult.message)"))

                return .failure(loginError)
            }
        }catch{
            return .failure(APIRequestError.UploadError("AuthService login"))
        }

    }
    
    // Add other Benevole-related API calls here

    func logout(){
        DispatchQueue.main.async {
            self.authManager.authToken = nil
            self.authManager.benevoleId = nil
            self.authManager.isAdmin = nil
        }
    }

}

