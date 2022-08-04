////
////  ReviewCell.swift
////  TV Show
////
////  Created by infinum on 29/07/2022.
////
//
//import UIKit
//
//class ReviewCell: UITableViewCell {
//
//    static let identifier = "ReviewCell"
//
//    // MARK: - Outlets
//
//    @IBOutlet private var titleLabel: UILabel!
//    @IBOutlet private var ratingView: RatingView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        ratingView.configure(withStyle: .small)
//        ratingView.isEnabled = false
//    }
//
//    func configure(with show: Show) {
//        titleLabel.text = show.title
////        ratingView.setRoundedRating(show.rating)
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}
