//
//  ReviewsTableViewCell.swift
//  TV Show
//
//  Created by infinum on 28/07/2022.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewsTableViewCell"

    // MARK: - Outlets
  
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var userId: UILabel!
    @IBOutlet private weak var ratingStars: RatingView!
    @IBOutlet private weak var userComments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingStars.configure(withStyle: .small)
        ratingStars.isEnabled = false
    }
}
