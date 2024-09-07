//
//  UISearchBar+ScopeBar.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 07/09/2024.
//

import UIKit

extension UISearchBar {
    var scopeBar: UIView? {
        let selector = NSSelectorFromString("_scopeBar")
        guard responds(to: selector) else { return nil }
        return value(forKey: "_scopeBar") as? UIView
    }
}
