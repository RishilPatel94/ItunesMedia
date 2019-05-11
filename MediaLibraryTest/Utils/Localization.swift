//
//  Localization.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//


import Foundation

enum ViewControllerString : String {
    case selectType = "Select Media Type"
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}


enum mediaType : String {
    case iosApps = "ios-apps"
    case itunesMusic = "itunes-music"
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
