//
//  UISearchBar+ScopeBarContainerView.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 07/09/2024.
//

import UIKit

extension UISearchBar {
    var scopeBarContainerView: UIView? {
        let selector = NSSelectorFromString("_scopeBarContainerView")
        guard responds(to: selector) else { return nil }
        return value(forKey: "_scopeBarContainerView") as? UIView
    }
}
