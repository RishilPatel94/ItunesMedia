//
//  FeedsControllerViewController.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import UIKit

class FeedsControllerViewController: UIViewController {

    var selectedMediaType : mediaType
    var feedList = [Result]()
    var myCollectionView:UICollectionView!
    
    
    init(mediaType:mediaType) {
        self.selectedMediaType = mediaType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = selectedMediaType.rawValue
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: ((self.view.frame.width - 20) / 2  - 5), height:  200)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "FeedCollectionViewCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
        myCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        var router : APIRouter!
        switch selectedMediaType {
        case .iosApps:
            router = APIRouter.getIosAppsFeed
        case .itunesMusic :
            router = APIRouter.itunesmusicApp
        }
        fetchFeed(router: router)
        // Do any additional setup after loading the view.
    }
    private func fetchFeed(router:APIRouter) {
        BaseApiClient.default.fetch(request: router) { (response:FeedRoot?) in
            if response != nil{
                if let result = response?.feed?.results , result.count > 0 {
                    self.feedList = result
                    self.myCollectionView.reloadData()
                }
            }
        }
    }


}
extension FeedsControllerViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath)
        if let annotateCell = cell as? FeedCollectionViewCell {
            let selectedFeed = feedList[indexPath.row]
            if let url = URL(string: selectedFeed.artworkUrl100 ?? "") , let name = selectedFeed.artistName {
                annotateCell.artistImage.kf.setImage(with: url, placeholder: UIImage(named: "placeHolderImage"))
                annotateCell.artistName.text = name
            }
        }
        return cell
    }
    
}
