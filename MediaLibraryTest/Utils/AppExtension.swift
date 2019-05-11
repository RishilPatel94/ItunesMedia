//
//  AppExtension.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    class  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIApplication {
    func gettopMostViewController() -> UIViewController? {
        return  self.keyWindow?.rootViewController?.findtopViewController()
    }
}


extension UIViewController {
    func findtopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return findtopViewController(controller: navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return findtopViewController(controller: presented)
        }
        return controller
    }
    
    func presentAlerterror(title:String,message:String, okclick:(()->())?) {
        let AlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if okclick != nil {
                okclick!()
            }
        }
        AlertController.addAction(okAction)
        self.present(AlertController, animated: true) {
            
        }
    }
}

