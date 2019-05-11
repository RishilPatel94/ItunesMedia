//
//  Constant.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Foundation
import UIKit

let textBoxBorderColor = "EBEBEB"
let themeColor = "00A0BF"




struct K {
    struct ProductionServer {
        static let baseURL = "https://rss.itunes.apple.com/api/v1/us/"
    }
    
    struct ItunesURl{
        static let baseURL = "https://rss.itunes.apple.com/api/v1/us/"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded"
}



