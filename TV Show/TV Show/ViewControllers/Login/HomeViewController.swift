//
//  HomeViewController.swift
//  TV Show
//
//  Created by infinum on 18/07/2022.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    // MARK: - Properties
    
    var userHeaders: [String: String] = [:]
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tvShows()
        
    }
    
    // MARK: - Actions
    
   
    
    // MARK: - Utility methods
    
    func tvShows() {
        let urlRequest = "https://tv-shows.infinum.academy/shows"
        AF
          .request(
              urlRequest,
              method: HTTPMethod.get,
              parameters: ["page": "1", "items": "100"], // pagination arguments
              headers: HTTPHeaders(userHeaders)
          )
          .validate()
            .responseDecodable(of: ShowsResponse.self) { response in
                switch response.result {
                case .success(let shows):
                    print("This is response: \(shows)")
                case .failure(let error):
                    print("Response failed! \(error)")
                }
            
            }
        
    }
}

