//
//  ViewController.swift
//  Apple-Music-Search-Tags-Demo
//
//  Created by Seb Vidal on 02/08/2024.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    private var searchController: TaggedSearchController!
    private var isCancelling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = TaggedSearchController()
        searchController.scopeBarActivation = .onSearchActivation
        searchController.searchBar.scopeButtonTitles = ["Apple Music", "Library"]
        searchController.searchBar.tagTitles = ["Top Results", "Artists", "Albums", "Songs", "Playlists", "Stations", "Profiles"]
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isCancelling = false
        
        UIView.animate(withDuration: 0.25) {
            self.searchController.searchBar.showsTags = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard isCancelling == false else { return }
        
        UIView.animate(withDuration: 0.25) {
            self.searchController.searchBar.showsTags = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isCancelling = true
    }
}
