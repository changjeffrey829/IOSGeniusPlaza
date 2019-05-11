//
//  MovieCell.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/10/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var stackLeadingAnchor: NSLayoutConstraint?
    
    var viewModel: MediaViewModel? {
        didSet {
            guard let vm = viewModel else {return}
            nameLabel.text = vm.rawMediaModel.name
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
        let stackView = UIStackView(arrangedSubviews: [nameLabel, mediaimageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackLeadingAnchor = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        stackLeadingAnchor?.isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
            stackLeadingAnchor?.constant = 8
        } else {
            stackLeadingAnchor?.constant = 50
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    var mediaimageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.image = #imageLiteral(resourceName: "smashBall.svg")
        return iv
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.clipsToBounds = true
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}