//
//  PickerClass.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class PickerView: UIView   {
    
    var dataSource = [String]()
    var pickerBottomView  = UIView()
    var bottomHeaderView = UIView()
    var picker = UIPickerView()
    var closeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close_White"), for: .normal)
        return button
    }()
    var selectButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Select_white"), for: .normal)
        return button
    }()
    var selecetionClouser : ((String)->())?
    var selectedMediaType = ""
    
    required init(datasource:[String],frame:CGRect) {
        self.dataSource = datasource
        super.init(frame: frame)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // xibSetup()
    }
    
    private func xibSetup() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        pickerBottomView.backgroundColor = UIColor.white
        bottomHeaderView.backgroundColor = UIColor.hexStringToUIColor(hex: themeColor)
        addComponent()
        setupConstraint()
        picker.delegate = self
        picker.dataSource = self
        closeButton.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        selectButton.addTarget(self, action: #selector(selectClick), for: .touchUpInside)
    }
    
    
    private func addComponent() {
        self.addSubview(pickerBottomView)
        pickerBottomView.addSubview(bottomHeaderView)
        pickerBottomView.addSubview(picker)
        bottomHeaderView.addSubview(closeButton)
        bottomHeaderView.addSubview(selectButton)
    }
    
    
    private func setupConstraint() {
        pickerBottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(250)
        }
        
        bottomHeaderView.snp.makeConstraints { (make) in
            make.top.equalTo(pickerBottomView.snp.top)
            make.left.right.equalTo(pickerBottomView)
            make.height.equalTo(40)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomHeaderView.snp.centerY)
            make.height.width.equalTo(30)
            make.left.equalTo(bottomHeaderView).offset(10)
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.right.equalTo(bottomHeaderView).offset(-10)
            make.height.width.equalTo(30)
            make.centerY.equalTo(bottomHeaderView.snp.centerY)
        }
        
        picker.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(pickerBottomView)
            make.top.equalTo(bottomHeaderView.snp.bottom)
        }
    }
    
    @objc func closeClick(sender: UIButton!) {
        self.removeFromSuperview()
    }
    
    @objc func selectClick(sender: UIButton!) {
        if selecetionClouser != nil {
            selecetionClouser!(selectedMediaType)
        }
        self.removeFromSuperview()
    }
    
}


extension PickerView : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 16 )
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = UIColor.black
        }
        pickerLabel?.text = dataSource[row]
        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMediaType = dataSource[row]
    }
}

