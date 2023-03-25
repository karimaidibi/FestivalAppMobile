//
//  SignUpService.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation
import SwiftUI

class SignUpService {
    var api : String
    
    init(){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
    }
    
    func signup(email: String, password: String) async -> Result<String?, Error> {

        guard let url = URL(string: "\(self.api)/benevoles/signup") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        let signUpInfo: SignUpDTO =  SignUpDTO(nom : "New User", prenom: "New User", email: email, password: password, affectations: [], isAdmin: false)
        guard let encoded : Data = await JSONHelper.encode(data: signUpInfo) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        // send the request
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpresponse = response as! HTTPURLResponse // le bon type
            // si tout se passe bien
            if httpresponse.statusCode == 201{
                // recuperer query result
                guard let _ : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                // si ok
                return .success("You are successfully signed up !")
            }
            // sinon afficher erreur avec le status code
            else {
                // sinon recuperer query bad result
                guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                // si bad result
                let signupError : AuthError = AuthError(message: queryBadResult.message)
                debugPrint(APIRequestError.UploadError("Bad Result In signup, code: \(queryBadResult.status), message : \(queryBadResult.message)"))

                return .failure(signupError)
                
            }
        }catch{
            return .failure(APIRequestError.UploadError("AuthService signup"))
        }
    }
}
