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
        setupLayout()
    }
    
    //MARK:- SETUP
    private func setupLayout() {
        addSubview(movieTitleLabel)
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(podCastTitleLabel)
        podCastTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        podCastTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        podCastTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        podCastTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        podCastTitleLabel.isHidden = true
        
        addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    //MARK:- UI OBJECTS
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie"
        label.textAlignment = .center
        label.backgroundColor = .brown
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    let podCastTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PodCast"
        label.textAlignment = .center
        label.backgroundColor = .brown
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
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
