//
//  ViewController.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var movieViewModel: HomeViewModel?
    var podCastViewModel: HomeViewModel?
    let headerView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MediaCell.self, forCellReuseIdentifier: HomeViewModel.cellID)
        setupViewModel()
        setupSegmentController()
    }
    
    @objc private func selectAMediaType() {
        tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    private func createErrorAlertController(networkError: MediaLoadingError) -> UIAlertController {
        let title: String
        switch networkError {
        case .imageError:
            title = "We're unable to load your image"
        case .mediaError:
            title = "We're unable to load your media"
        }
        let alert = UIAlertController(title: title, message: "Please try again later", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        return alert
    }
    
    //MARK:- SETUP
    
    private func setupSegmentController() {
        headerView.segmentedControl.addTarget(self, action: #selector(selectAMediaType), for: .valueChanged)
    }
    
    private func setupViewModel() {
        setupMovieViewModels()
        setupPodCastViewModel()
    }
    
    private func setupPodCastViewModel() {
        let networkService = NetworkService(mediaType: .podCast)
        podCastViewModel = HomeViewModel(mediaService: networkService)
        podCastViewModel?.loadMedia(completion: { [unowned self] (error) in
            if let error = error {
                let alert = self.createErrorAlertController(networkError: error)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    private func setupMovieViewModels() {
        let networkService = NetworkService(mediaType: .movie)
        movieViewModel = HomeViewModel(mediaService: networkService)
        movieViewModel?.loadMedia(completion: { [unowned self] (error) in
            if let error = error {
                let alert = self.createErrorAlertController(networkError: error)
                self.present(alert, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
}

//MARK:- TABLEVIEW
extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HomeViewModel.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = headerView.segmentedControl.selectedSegmentIndex
        let count = index == 0 ? movieViewModel?.mediaCount() : podCastViewModel?.mediaCount()
        return count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewModel.cellID, for: indexPath) as? MediaCell
        let index = headerView.segmentedControl.selectedSegmentIndex
        let viewModel = index == 0 ? movieViewModel?.mediaViewModelAtIndex(indexPath.row) : podCastViewModel?.mediaViewModelAtIndex(indexPath.row)
        cell?.viewModel = viewModel
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeViewModel.cellHeight
    }
}
