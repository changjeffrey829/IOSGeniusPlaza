//
//  HeaderView.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/11/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegmentControllerLayout()
    }
    
    //MARK:- SETUP
    private func setupSegmentControllerLayout() {
        addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    //MARK:- UI OBJECT
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Top 10 Movies", "Top 10 Podcast"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .white
        sc.tintColor = .brown
        return sc
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
