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
  
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var ratingStars: UILabel!
    @IBOutlet weak var userComments: UILabel!
    
}
