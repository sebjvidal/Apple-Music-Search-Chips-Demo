//
//  UISegmentedControl+SetTitles.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 07/09/2024.
//

import UIKit

extension UISegmentedControl {
    func setTitles(_ titles: [String]?) {
        if let titles {
            for title in titles.reversed() {
                insertSegment(withTitle: title, at: 0, animated: false)
            }
            selectedSegmentIndex = 0
        } else {
            removeAllSegments()
        }
    }
}
