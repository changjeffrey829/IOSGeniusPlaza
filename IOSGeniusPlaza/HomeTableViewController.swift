//
//  ViewController.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieCell.self, forCellReuseIdentifier: HomeViewModel.cellID)
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = HomeViewModel()
        viewModel?.loadMovies(completion: { [unowned self] (err) in
            if err != nil {
                let alert = self.createConnectionAlertController()
                self.present(alert, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func createConnectionAlertController() -> UIAlertController {
        let alert = UIAlertController(title: "Unable to connect to internet", message: "Please try again later", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        return alert
    }
    
}

extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.moviesCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewModel.cellID, for: indexPath) as? MovieCell
        cell?.viewModel = viewModel?.MediaViewModelAtIndex(indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
