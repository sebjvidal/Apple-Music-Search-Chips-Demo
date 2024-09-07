//
//  TagsView.swift
//  Apple-Music-Search-Chips-Demo
//
//  Created by Seb Vidal on 07/09/2024.
//

import UIKit

class TagsView: UIScrollView {
    private var bottomStackView: UIStackView!
    private var topStackView: UIStackView!
    private var backgroundView: UIView!
    private var tagMaskView: UIView!
    
    var titles: [String] = [] {
        didSet { updateButtons(for: titles) }
    }
    
    var selectedTagIndex: Int = 0 {
        didSet { updateSelection(for: selectedTagIndex) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupBottomStackView()
        setupTopStackView()
        setupBackgroundView()
        setupTagMaskView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        alwaysBounceHorizontal = true
        showsHorizontalScrollIndicator = false
    }
    
    private func setupBottomStackView() {
        bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillProportionally
        bottomStackView.isLayoutMarginsRelativeArrangement = true
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: topAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTopStackView() {
        topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.isUserInteractionEnabled = false
        topStackView.distribution = .fillProportionally
        topStackView.isLayoutMarginsRelativeArrangement = true
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topStackView)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupBackgroundView() {
        backgroundView = UIView()
        backgroundView.clipsToBounds = true
        backgroundView.backgroundColor = .tintColor
        backgroundView.layer.cornerCurve = .continuous
        
        insertSubview(backgroundView, aboveSubview: bottomStackView)
    }
    
    private func setupTagMaskView() {
        tagMaskView = UIView()
        tagMaskView.clipsToBounds = true
        tagMaskView.backgroundColor = .black
        tagMaskView.layer.cornerCurve = .continuous
        
        topStackView.mask = tagMaskView
    }
    
    private func updateButtons(for titles: [String]) {
        bottomStackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        topStackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        for title in titles {
            let bottomButton = button(with: title, foregroundColor: .label)
            bottomStackView.addArrangedSubview(bottomButton)
            
            let topButton = button(with: title, foregroundColor: .white)
            topStackView.addArrangedSubview(topButton)
        }
    }
    
    private func button(with title: String, foregroundColor: UIColor) -> UIButton {
        let titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { container in
            var container = container
            container.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            
            return container
        }
        
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.configuration?.title = title
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseForegroundColor = foregroundColor
        button.configuration?.titleTextAttributesTransformer = titleTextAttributesTransformer
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8.33, leading: 12, bottom: 8, trailing: 12.66)
        button.addTarget(self, action: #selector(tagButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    @objc private func tagButtonTapped(_ sender: UIButton) {
        UIView.animate(springDuration: 0.25, bounce: 0.25) {
            selectedTagIndex = bottomStackView.arrangedSubviews.firstIndex(of: sender)!
        }
    }
    
    private func updateSelection(for selectedTagIndex: Int) {
        if bottomStackView.arrangedSubviews.indices.contains(selectedTagIndex) {
            let button = bottomStackView.arrangedSubviews[selectedTagIndex]
            
            tagMaskView.layer.cornerRadius = button.frame.height / 2
            tagMaskView.frame = button.frame
            
            backgroundView.layer.cornerRadius = button.frame.height / 2
            backgroundView.frame = button.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UIView.performWithoutAnimation { [unowned self] in
            updateSelection(for: selectedTagIndex)
        }
    }
}
