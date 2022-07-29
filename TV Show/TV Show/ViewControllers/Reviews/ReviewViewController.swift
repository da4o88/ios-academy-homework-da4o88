//
//  ReviewViewController.swift
//  TV Show
//
//  Created by infinum on 27/07/2022.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD

class ReviewViewController: UIViewController {
    
   
    
    // MARK: - Outlets
   

    
    // MARK: - Properties
    let getHeaders = HomeViewController.sharedInstance
    
    var showInfo: Show? = nil
    var showReview: [Review] = []
    

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("dali e toa: \(String(describing: showInfo))")
//        showReviews()
        
//        let navigationController = UINavigationController(rootViewController: writeReviewController)
//        present(navigationController, animated: true)
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Novo Resume"
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

}
//
//extension ReviewViewController {
//
//// MARK: - Utility methods
//
//func showReviews() {
//    let headers = getHeaders.userHeaders
//    MBProgressHUD.showAdded(to: self.view, animated: true)
//    // create token access and remove email and password
//    let parameters: [String: String?] = [
//        "email": "d@infinum.com",
//        "password": "daniel"
//    ]
//
//    var urlShowId:String! = showInfo?.id
//    var id = Int(urlShowId)
//    let urlRequest = "https://tv-shows.infinum.academy/shows/\(id ?? 0)/reviews"
//    print("URL patekata: \(urlRequest)")
//    AF
//      .request(
//          urlRequest,
//          method: HTTPMethod.get,
//          parameters: parameters,
//          headers: HTTPHeaders(headers)
//      )
//      .validate()
//        .responseDecodable(of: ReviewResponse.self) { [weak self] response in
//            guard let self = self else {return}
//            MBProgressHUD.hide(for: self.view, animated: true)
//            switch response.result {
//            case .success(let showReviews):
//                print(showReviews)
//
//
////                self.tableViewData = tvShows.shows
////                self.tableView.reloadData()
////
//            case .failure(let error):
//                print("Response failed! \(error)")
//            }
//
//        }
//
//}
//
//
//}
