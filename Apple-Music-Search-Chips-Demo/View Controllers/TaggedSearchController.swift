//
//  TaggedSearchController.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 07/09/2024.
//

import UIKit

class TaggedSearchController: UISearchController {
    private lazy var _searchBar = TaggedSearchBar()
    
    override var searchBar: TaggedSearchBar {
        return _searchBar
    }
}
