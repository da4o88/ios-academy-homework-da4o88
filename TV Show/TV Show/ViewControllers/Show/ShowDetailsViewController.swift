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
import MBProgressHUD

class ShowDetailsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        table.register(ShowTableViewCell.self, forCellReuseIdentifier: ShowTableViewCell.identifier)
        table.register(ReviewsTableViewCell.self, forCellReuseIdentifier: ReviewsTableViewCell.identifier)
        
        
        return table
    }()
    
    // MARK: - Outlets
   
//    @IBOutlet weak var tableView: UITableView!
   
    // MARK: - Properties

    let authData = AuthInfoData.shared
    var showData: Show? = nil
    var reviewsData: [Review] = []
    var showId: Int = 0
    
    // MARK: - Properties 2
    
//    var showInfo: Show? = nil
//    var showReview: [Review] = []
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1200
       
        getShowReviews()
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
    
    // MARK: - Action
    
    @IBAction func didTapBUttonReview(_ sender: Any) {
//        presentToReviewScreen()
    }
    
}


    // MARK: - Two TableViewCells

    
extension ShowDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        let cellShow = tableView.dequeueReusableCell(withIdentifier: String(describing: ShowTableViewCell.self) , for: indexPath) as! ShowTableViewCell
        let url = URL(string: (showData?.imageUrl)!)
        cellShow.showImage.kf.setImage(with: url, placeholder: UIImage(named: "ic-show-placeholder-vertical"))
        cellShow.showDescription.text = showData?.description
        cellShow.showReviews.text = "Reviews"
        print("showData: \(String(describing: indexPath.section))")
        let numOfReviews = showData?.numOfReviews
        let numOfAverageReviews = showData?.averageRating

        cellShow.showNumOfReviews.text = "\(String(describing: numOfReviews!))   REVIEWS   \(String(describing: numOfAverageReviews!))    AVERAGE"
        
        cellShow.showRatingStars.rating = 4
        
        return cellShow
        } else {
            let cellShow = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewsTableViewCell.identifier ) , for: indexPath) as! ReviewsTableViewCell
//            let url1 = URL(string: (showData?.imageUrl)!)
            
            
            cellShow.userId.text = "My new ID is NEW"
            cellShow.ratingStars.rating = 4
            cellShow.userComments.text = "Malku komentari za idninita"
            
            
            return cellShow
        }
    }
    
}


extension ShowDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Change to dynamic  Here check again
      
        return 570
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected shows")
    }
}

extension ShowDetailsViewController {
    
    
    // MARK: - Utility
    
    func presentToReviewScreen() {
        let reviewScreen = self.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
//        reviewScreen.navigationItem.largeTitleDisplayMode = .never
//        reviewScreen.navigationController?.isNavigationBarHidden = false
        reviewScreen.showInfo = showData?.id
        reviewScreen.showId = showId
//        reviewScreen.reviewData = showData.id 


//        reviewScreen.showData = data
//        homeScreen.userHeaders = headers
        self.navigationController?.present(reviewScreen, animated: true)
        
        // Something new
        
        let editorViewController = reviewScreen
         let navEditorViewController: UINavigationController = UINavigationController(rootViewController: editorViewController)
        self.present(navEditorViewController, animated: true, completion: nil)

        
        
    }
}


extension ShowDetailsViewController {


    // MARK: - Utility methods

    func getShowReviews() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let urlShowId:String! = showData?.id
        let id = Int(urlShowId)
        let urlRequest = "https://tv-shows.infinum.academy/shows/\(id ?? 0)/reviews"
        self.showId = id!
        print("URL patekata: \(urlRequest), \(self.showId)")
        AF
          .request(
              urlRequest,
              method: HTTPMethod.get,
              parameters: ["page": "1", "items": "20"],
              headers: HTTPHeaders(authData.authInfo!.headers)
          )
          .validate()
            .responseDecodable(of: ReviewResponse.self) { [weak self] response in
                guard let self = self else {return}
                MBProgressHUD.hide(for: self.view, animated: true)
                switch response.result {
                case .success(let showReviews):
                    self.reviewsData = showReviews.reviews
                    self.tableView.reloadData()
                    
//                    print("RESPONSE: \(response)")
//                    print("REVIEWS: \(showReviews.reviews.rating)")
//                    print("REVIEWS DATA: \(self.reviewsData)")
    
                case .failure(let error):
                    print("Response failed! \(error)")
                }

            }

    }
}
