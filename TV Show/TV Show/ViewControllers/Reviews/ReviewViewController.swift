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
import SwiftUI


class ReviewViewController: UIViewController {
    
    
    
    // MARK: - Outlets
    
 
    @IBOutlet weak var tableReview: UITableView!
    @IBOutlet weak var closeBackButton: UIBarButtonItem!
    @IBOutlet weak var userComment: UITextField!
    @IBOutlet weak var submitButtonView: UIButton!
    
    // MARK: - Properties
    
    let authData = AuthInfoData.shared
    var showInfo: String? = nil
    var reviewData: Show? = nil
    var showId: Int = 0
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        closeBackButton.title = "Close"
        
        tableReview.dataSource = self
        tableReview.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        roundedButtons()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    }

}

extension ReviewViewController {
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        dismissOrPop()
    }
    
    @IBAction func submitButton(sender: UIButton) {
        postReview()
        
    }
}

extension ReviewViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableReview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewTableViewCell
        cell.titleLabel.text = "Rating"
        cell.ratingView.isEnabled = true
        cell.ratingView.rating = 4

        return cell
    }
    
    
}

extension ReviewViewController {
    

        // MARK: - Utility methods

        func postReview() {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let rating = 3
            guard let userComment = userComment.text else {
                return
            }
            let urlRequest = "https://tv-shows.infinum.academy/reviews"
            print("URL patekata: \(urlRequest)")
            let parameters: [String: Any] = [
                "rating": rating,
                "comment": userComment,
                "show_id": showId
                
            ]
            
            AF
              .request(
                  urlRequest,
                  method: HTTPMethod.post,
                  parameters: parameters,
                  headers: HTTPHeaders(authData.authInfo!.headers)
                  
              )
              .validate()
                .responseDecodable(of: Review.self) { [weak self] response in
                    guard let self = self else {return}
                    MBProgressHUD.hide(for: self.view, animated: true)
                    switch response.result {
                    case .success(let showReviews):
                       
                        
                        
                        print("RESPONSE: \(showReviews)")
    //                    print("REVIEWS: \(showReviews.reviews.rating)")
    //                    print("REVIEWS DATA: \(self.reviewsData)")
        
                    case .failure(let error):
                        print("Sending review failed! \(error)")
                        let message = "Sending your review failed. Try again!"
                        self.alertMessage(message: message)
                    }

                }

        }

    
}

extension ReviewViewController {
    func alertMessage(message: String?) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated:true) {
            return
        }
    }
    
    private func roundedButtons() -> Void {
        submitButtonView.layer.cornerRadius = 24
        submitButtonView.layer.masksToBounds = true
    }
}

extension UIViewController {
    func dismissOrPop() {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else if navigationController?.presentingViewController != nil,
                  navigationController?.viewControllers.count == 1 {
            navigationController?.popViewController(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
