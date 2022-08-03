//
//  ShowTableViewCell.swift
//  TV Show
//
//  Created by infinum on 27/07/2022.
//

import UIKit
import Kingfisher

class ShowTableViewCell: UITableViewCell {
    
    static let identifier = "ShowTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var showDescription: UILabel!
    @IBOutlet private weak var showReviews: UILabel!
    @IBOutlet private weak var showNumOfReviews: UILabel!
    @IBOutlet private weak var showRatingStars: RatingView!
    
    
    // MARK: - Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        showRatingStars.configure(withStyle: .small)
        showRatingStars.isEnabled = false
    }
}
