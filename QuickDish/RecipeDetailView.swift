//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  RecipeDetailView.swift
//  QuickDish
//
//  Created by Vardan Malik on 5/04/25.
//

import UIKit

class RecipeDetailView: UIView {
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configure(with instructions: String) {
        instructionsLabel.text = instructions
        setupLayout()
    }

    private func setupLayout() {
        addSubview(instructionsLabel)
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            instructionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        backgroundColor = UIColor(white: 0.1, alpha: 1)
        layer.cornerRadius = 10
    }
}
