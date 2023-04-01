//
//  BenevoleAPIService.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

// BenevoleAPIService.swift
import Foundation
import Combine

class BenevoleService {
    
    var api : String
    
    init(){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
    }
    
    
    func getBenevoles() async -> Result<[BenevoleDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles") else {
            return .failure(APIRequestError.unknown)
        }
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.data(from : url)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 200 {
                    // recuperer query result
                    guard let decoded : QueryResult<BenevoleDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let benevoleDTOs : [BenevoleDTO] = decoded.result
                    return .success(benevoleDTOs)
                }else{
                    // si le status est autre que 200
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.getRequestError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("getBenevoles"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
        
    }
    
    func getBenevoleById(id: String) async -> Result<BenevoleDTO, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/\(id)") else {
            return .failure(APIRequestError.unknown)
        }
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.data(from : url)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 200 {
                    // recuperer query result
                    guard let decoded : QueryResultGetOne<BenevoleDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let benevoleDTO : BenevoleDTO = decoded.result
                    return .success(benevoleDTO)
                }else{
                    // si le status est autre que 200
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.getRequestError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("ge benevole by id"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }
    
    // get all affectations of the benevole
    func getBenevoleAffectations(id: String) async -> Result<[AffectationDocDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/\(id)/affectations") else {
            return .failure(APIRequestError.unknown)
        }
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.data(from : url)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 200 {
                    // recuperer query result
                    guard let decoded : QueryResult<AffectationDocDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let affectations : [AffectationDocDTO] = decoded.result
                    return .success(affectations)
                }else{
                    // si le status est autre que 200
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.getRequestError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("get benevole affectations"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }
    
    func removeAffectation(id: String, affectation : AffectationDTO) async -> Result<String?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/\(id)/removeAffectation") else {
            return .failure(APIRequestError.unknown)
        }
        
        // define the put request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the affectationDTO data
        guard let encoded : Data = await JSONHelper.encode(data: affectation) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 204 {
                    return .success("Affectation deleted successfully.")
                }else{
                    // si le status est autre que 204
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.UploadError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("removeAffectations"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }
    
    func addAffectation(benevoleId : String, affectationDTO : AffectationDTO) async -> Result<String, Error> {

        guard let url = URL(string: "\(self.api)/benevoles/\(benevoleId)/addAffectation") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        guard let encoded : Data = await JSONHelper.encode(data: affectationDTO) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        // send the request
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpresponse = response as! HTTPURLResponse // le bon type
            // si tout se passe bien
            if httpresponse.statusCode == 200{
                // recuperer query result
                guard let decoded : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                let successMessage = decoded.message
                return .success(successMessage)
            }
            // sinon afficher erreur avec le status code
            else {
                // sinon recuperer query bad result
                guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                // si bad result
                return .failure(APIRequestError.UploadError("\(queryBadResult.status) : \(queryBadResult.message)"))
            }
        }catch{
            return .failure(APIRequestError.UploadError("Add Affectation"))
        }

    }
    
    // get all benevoles with nested affectations
    func getBenevolesNested() async -> Result<[BenevoleDocDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/getBenevoles/Nested") else {
            return .failure(APIRequestError.unknown)
        }
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.data(from : url)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 200 {
                    // recuperer query result
                    guard let decoded : QueryResult<BenevoleDocDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let benevoles : [BenevoleDocDTO] = decoded.result
                    return .success(benevoles)
                }else{
                    // si le status est autre que 200
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.getRequestError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("get benevole with nested affectations"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }


}
