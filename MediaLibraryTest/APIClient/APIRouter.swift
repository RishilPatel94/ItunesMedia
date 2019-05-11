//
//  APIRouter.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getIosAppsFeed
    case itunesmusicApp
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case  .getIosAppsFeed,.itunesmusicApp :
            return .get
        }
    }
    
    
    //MARK:- encoding
    
    var encoding: ParameterEncoding {
        return method == .post ? URLEncoding() : JSONEncoding.prettyPrinted
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getIosAppsFeed:
            return "ios-apps/new-apps-we-love/all/25/explicit.json"
        case .itunesmusicApp:
            return "itunes-music/hot-tracks/all/25/explicit.json"
        }
    }
    
    var fullURL: String {
        return K.ProductionServer.baseURL + path
    }
    
    
    var headers: HTTPHeaders {
        
        return ["Content-Type" :ContentType.json.rawValue]
    }
    
    
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getIosAppsFeed,.itunesmusicApp :
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url:URL(string: K.ProductionServer.baseURL + path)! )
        
        
        
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
                return encodedURLRequest
            } catch  {
                
            }
        }
        return urlRequest
    }
}
