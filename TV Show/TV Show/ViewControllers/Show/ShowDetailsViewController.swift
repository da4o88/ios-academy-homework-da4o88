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
    
    // MARK: - Properties 2
    

    
    var showInfo: Show? = nil
    var showReview: [Review] = []
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1200
       
        showReviews()
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
        pushToReviewScreen()
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

        return cellShow
        } else {
            let cellShow = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewsTableViewCell.identifier ) , for: indexPath) as! ReviewsTableViewCell
//            let url1 = URL(string: (showData?.imageUrl)!)
            cellShow.userComments.text = "Nekakvi komentari za sega"
            cellShow.userId.text = "My new ID is NEW"
            
            
            return cellShow
        }
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
    
    
    // MARK: - Utility
    
    func pushToReviewScreen() {
        let reviewScreen = self.storyboard?.instantiateViewController(withIdentifier: "ReviewScreen") as! ReviewViewController
        reviewScreen.navigationItem.largeTitleDisplayMode = .never
        reviewScreen.navigationController?.isNavigationBarHidden = false
        reviewScreen.showInfo = showData
        
//        reviewScreen.showData = data
//        homeScreen.userHeaders = headers
        self.navigationController?.present(reviewScreen, animated: true)
        
    }
}


extension ShowDetailsViewController {


    // MARK: - Utility methods

    func showReviews() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let urlShowId:String! = showData?.id
        let id = Int(urlShowId)
        let urlRequest = "https://tv-shows.infinum.academy/shows/\(id ?? 0)/reviews"
        print("URL patekata: \(urlRequest)")
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
                    print("RESPONSE: \(response)")
                    print("REVIEWS: \(showReviews)")


    //                self.tableViewData = tvShows.shows
    //                self.tableView.reloadData()
    //
                case .failure(let error):
                    print("Response failed! \(error)")
                }

            }

    }


}
