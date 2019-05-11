//
//  TextBoxView.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class TextBoxView: UIView  {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
        
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    
    func commoninit() {
        self.layer.borderColor = UIColor.hexStringToUIColor(hex:textBoxBorderColor).cgColor
        self.layer.borderWidth = 1
    }
}
