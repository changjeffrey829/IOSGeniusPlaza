//
//  MovieCell.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/10/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    
    var stackLeadingAnchor: NSLayoutConstraint?
    
    var viewModel: MediaViewModel? {
        didSet {
            guard let vm = viewModel else {return}
            nameLabel.attributedText = vm.getMediaName()
            mediaTypeLabel.attributedText = vm.getMediaTypeString()
            vm.getImagefromURL { [unowned self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(_):
                        self.mediaimageView.image = #imageLiteral(resourceName: "smashBall.svg")
                    case .success(let image):
                        self.mediaimageView.image = image
                    }
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
            stackLeadingAnchor?.constant = 16
        } else {
            stackLeadingAnchor?.constant = 40
        }
    }
    
    //MARK:- SETUP
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, mediaTypeLabel, mediaimageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackLeadingAnchor = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        stackLeadingAnchor?.isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    //MARK:- UI OBJECTS
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Media Name"
        label.numberOfLines = 0
        return label
    }()
    
    var mediaimageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.image = #imageLiteral(resourceName: "smashBall.svg")
        return iv
    }()
    
    let mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Media Type"
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
