//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  IngredientsView.swift
//  QuickDish
//
//  Created by Vardan Malik on 5/04/25.
//

import UIKit

class IngredientsView: UIView {

    private var stack: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        addSubview(stack)

        layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        preservesSuperviewLayoutMargins = true

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with ingredients: [String]) {
        // Clear previous labels if re-used
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for item in ingredients {
            let label = UILabel()
            label.text = "• \(item)"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            stack.addArrangedSubview(label)
        }
    }
}
