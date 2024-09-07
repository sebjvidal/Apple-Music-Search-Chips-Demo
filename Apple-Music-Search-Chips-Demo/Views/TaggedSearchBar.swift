//
//  TaggedSearchBar.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 07/09/2024.
//

import UIKit

class TaggedSearchBar: UISearchBar {
    private var segmentedControl: UISegmentedControl!
    private var tagsView: TagsView!
    
    override var scopeButtonTitles: [String]? {
        didSet {
            segmentedControl.setTitles(scopeButtonTitles)
        }
    }
    
    var showsTags: Bool = false {
        didSet {
            layoutSegmentedControl()
            layoutTagsView()
        }
    }
    
    var tagTitles: [String] {
        get {
            return tagsView.titles
        } set {
            tagsView.titles = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegmentedControl()
        setupTagsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSegmentedControl() {
        segmentedControl = UISegmentedControl()
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.searchBar?(self, selectedScopeButtonIndexDidChange: sender.selectedSegmentIndex)
    }
    
    private func setupTagsView() {
        tagsView = TagsView()
        tagsView.alpha = 0
    }
    
    private func layoutSegmentedControl() {
        if let scopeBar {
            segmentedControl.frame.size = scopeBar.frame.size
            segmentedControl.frame.origin.x = scopeBar.frame.origin.x
            segmentedControl.frame.origin.y = showsTags ? -scopeBar.frame.height : scopeBar.frame.origin.y
            
            segmentedControl.alpha = showsTags ? 0 : 1
        }
    }
    
    private func layoutTagsView() {
        if let scopeBarContainerView {
            tagsView.frame.size = scopeBarContainerView.frame.size
            tagsView.frame.origin.x = 0
            tagsView.frame.origin.y = showsTags ? 0 : scopeBarContainerView.frame.height
            
            tagsView.alpha = showsTags ? 1 : 0
            
            let contentInset = searchTextField.frame.origin.x
            let safeAreaInset = safeAreaInsets.left
            tagsView.contentInset.left = contentInset - safeAreaInset
            tagsView.contentInset.right = contentInset - safeAreaInset
            tagsView.contentOffset.x = -contentInset
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        scopeBar?.isHidden = true
        scopeBarContainerView?.addSubview(segmentedControl)
        scopeBarContainerView?.addSubview(tagsView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSegmentedControl()
        layoutTagsView()
    }
}
