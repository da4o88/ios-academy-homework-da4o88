//
//  ReviewTableViewCell.swift
//  TV Show
//
//  Created by infinum on 31/07/2022.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    
    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingView.configure(withStyle: .large)
        ratingView.isEnabled = true
    }
    
    func configure(with show: Show) {
        titleLabel.text = show.title
        ratingView.setRoundedRating(show.averageRating!)
    }
}
