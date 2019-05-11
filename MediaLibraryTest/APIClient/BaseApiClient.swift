//
//  BaseApiClient.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Foundation
import Alamofire

class BaseApiClient {
    
    static let `default`  = BaseApiClient()
    
    private init() {
        
    }
    
    func fetch<model:Codable>(request:APIRouter,decoder : JSONDecoder = JSONDecoder()  ,onSuccess: @escaping (model?) -> Void) {
        
        print("Request URL ========> \(request.fullURL)")
        print("Request PARAMTER ========> \(request.parameters)")
        print("Request Header ========> \(request.headers)")
        if Connectivity.isReachable {
            (UIApplication.shared.delegate as! AppDelegate).addProgressView()
            Alamofire.request(request).responseJSON { (response) in
                
                
                
                switch response.result {
                case .success( let apiResponse) :
                    
                    print("Request Response ========> \(apiResponse)")
                    
                    DispatchQueue.main.async {
                        (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
                    }
                    
                    if let responseData = apiResponse as? [String:Any] , let status  = responseData["feed"] as? [String:Any] {
                        do {
                            let responseModel  = try decoder.decode(model.self, from: response.data!)
                            onSuccess(responseModel)
                        }
                        catch let error as NSError {
                            // onSuccess(nil)
                            print("failed reason : \(error.localizedDescription)")
                        }
                        
                        
                    }
                    else {
                        //                        onSuccess(nil)
                        UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Erorr", message: "An error has occurred." ,okclick: nil)
                    }
                case .failure(let error) :
                    //                    onSuccess(nil)
                    DispatchQueue.main.async {
                        (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
                    }
                    UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Erorr", message: error.localizedDescription, okclick: nil)
                }
            }
        }
        else {
            //            onSuccess(nil)
            (UIApplication.shared.delegate as! AppDelegate).hideProgrssVoew()
            UIApplication.shared.gettopMostViewController()?.presentAlerterror(title: "Error", message: "connnection not avilabel", okclick: nil)
        }
    }
    
}


class Connectivity {
    class var isReachable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}




struct ResponseBaseArray<T:Codable> : Codable {
    
    let code : String?
    let data : [T]?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case data = "Data"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent([T].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct ResponseBaseObject<T:Codable> : Codable {
    
    let code : String?
    let data : T?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case data = "Data"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
