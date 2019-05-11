//
//  FeedCollectionViewCell.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCollectionViewCell: UICollectionViewCell {
    var artistName : UILabel = {
        let labael = UILabel()
        labael.textColor = UIColor.black
        labael.font = UIFont.systemFont(ofSize: 12)
        return labael
    }()
    var artistImage = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(artistName)
        self.contentView.addSubview(artistImage)
        artistName.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(0)
            make.height.equalTo(50)
        }
        artistImage.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(artistName.snp.bottom)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

