//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  FavoriteTableViewCell.swift
//  QuickDish
//
//  Created by Saisowmith Reddy Katkuri on 4/29/25.
//

import Foundation
import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startCookingButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    var onUnfavoriteTapped: (() -> Void)?
    var onStartCookingTapped: (() -> Void)?


//    @IBAction func heartButtonTapped(_ sender: UIButton) {
//        onUnfavoriteTapped?()
//    }
    
    weak var delegate: FavoriteTableViewCellDelegate?
    
    // Notifies delegate when heart button is tapped.
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        delegate?.didTapHeart(on: self)
    }
    
    // Triggers start cooking closure when button is tapped.
    @IBAction func startCookingButtonTapped(_ sender: UIButton) {
        onStartCookingTapped?()
    }

    
}

// Protocol to notify when heart button is tapped in the cell.
protocol FavoriteTableViewCellDelegate: AnyObject {
    func didTapHeart(on cell: FavoriteTableViewCell)
}


