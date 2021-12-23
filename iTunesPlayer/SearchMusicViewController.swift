//
//  SearchViewController.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 21.12.2021.
//

import UIKit
import Alamofire

class SearchMusicViewController: UITableViewController {
    
    var tracks = [Track]()
    let searchController = UISearchController(searchResultsController: nil)
    var networkManager = NetworkManager()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSearchBar()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = tracks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.image = #imageLiteral(resourceName: "tecca")
        content.text = "\(track.trackName ?? "No track name")\n\(track.artistName)"
        content.imageProperties.cornerRadius = 33
        content.textProperties.numberOfLines = 2
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchMusicViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] _ in
            self.networkManager.fetchTracks(searchText: searchText) { [weak self] searchResults in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
        
    }
}
