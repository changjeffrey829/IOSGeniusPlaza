//
//  ViewController.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let cellID = "cellID"
    var viewModel: ViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupViewModel()
    }
    
    func setupViewModel() {
        let networkService = NetworkService()
        viewModel = ViewModel(networkService: networkService)
        viewModel?.loadMovies(completion: { [unowned self] (err) in
            if err != nil {
                let alert = UIAlertController(title: "Unable to connect to internet", message: "Please try again later", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                alert.addAction(dismissAction)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
}

extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.moviesCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}
