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
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var showReviews: UILabel!
    @IBOutlet weak var showNumOfReviews: UILabel!
    @IBOutlet weak var showRatingStars: RatingView!
    
    
    // MARK: - Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        showRatingStars.configure(withStyle: .small)
        showRatingStars.isEnabled = false
    }
    
}
