//
//  ViewController.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var outerView : TextBoxView = {
        let view = TextBoxView()
        return view
    }()
    
    var selectButton : UIButton = {
        let button = UIButton()
        button.setTitle(ViewControllerString.selectType.localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(
            self,
            action: #selector(openPickerView), // 2
            for: .touchUpInside
        )
        return button
    }()
    
    var pickerView  : PickerView!
    var selectedType : mediaType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupComponent()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupComponent() {
        func addComponent() {
            self.navigationItem.title = "Itunes Media"
            self.view.addSubview(outerView)
            outerView.addSubview(selectButton)
            pickerView = PickerView(datasource: [mediaType.iosApps.localized(),mediaType.itunesMusic.localized()], frame: self.view.bounds)
            pickerView.selecetionClouser = { [weak self] selectedType in
                self?.selectedType = mediaType(rawValue: selectedType)
               let feedController = FeedsControllerViewController(mediaType: self?.selectedType ?? mediaType.iosApps)
                self?.navigationController?.pushViewController(feedController, animated: true)
            }
        }
        
        func setupConstaraint() {
            outerView.snp.makeConstraints { (make) in
                make.top.equalTo(100)
                make.width.equalTo(200)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(45)
            }
            
            selectButton.snp.makeConstraints { (make) in
                make.edges.equalTo(outerView).offset(2)
            }
        }
        addComponent()
        setupConstaraint()
    }
    @objc private func openPickerView() {
        self.view.addSubview(pickerView)
    }
}


