//
//  ShowDetailsViewController.swift
//  TV Show
//
//  Created by infinum on 27/07/2022.
//

import Foundation
import UIKit
import Kingfisher
import Alamofire

class ShowDetailsViewController: UIViewController {
    
    // MARK: - Outlets
   
    @IBOutlet weak var tableView: UITableView!
   
    // MARK: - Properties

    var showData: Show? = nil
//    var showData: AnyObject = [] as AnyObject
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1200
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = showData?.title
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}



extension ShowDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // pass data info for show
        let cellShow = tableView.dequeueReusableCell(withIdentifier: String(describing: ShowTableViewCell.self) , for: indexPath) as! ShowTableViewCell
        let url = URL(string: (showData?.imageUrl)!)
        cellShow.showImage.kf.setImage(with: url, placeholder: UIImage(named: "ic-show-placeholder-vertical"))
        cellShow.showDescription.text = showData?.description
        cellShow.showReviews.text = "Reviews"
        print("showData: \(String(describing: showData))")
        let numOfReviews = showData?.numOfReviews
        let numOfAverageReviews = showData?.averageRating
        
        cellShow.showNumOfReviews.text = "\(String(describing: numOfReviews!))   REVIEWS   \(String(describing: numOfAverageReviews!))    AVERAGE"
//        cellShow.showReviews.text = "\(String(describing: showData!.numOfReviews))"
        

        return cellShow
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Add what is needed to return  1
        return 1
    }
}

extension ShowDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Change to dynamic  Here check again
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected shows")
    }
}

extension ShowDetailsViewController {
    

    
//    // MARK: - Utility
//    
//    public func pushToReviewScreen() {
//        let reviewScreen = self.storyboard?.instantiateViewController(withIdentifier: "reviewScreen") as! ReviewViewController
//        reviewScreen.navigationItem.largeTitleDisplayMode = .never
//        reviewScreen.navigationController?.isNavigationBarHidden = false
////        reviewScreen.showData = data
////        homeScreen.userHeaders = headers
//        self.navigationController?.pushViewController(reviewScreen, animated: true)
//        
//    }
//}

}
