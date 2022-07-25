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
   
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties

    var userHeaders: [String: String] = [:]
    var tableViewData: [ShowsResponse] = []
    
    private let items = Array(repeating: "Cell", count: 100)
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Shows"
        self.navigationItem.setHidesBackButton(true, animated: true)
        tvShows()
        tableView.dataSource = self
        
    }
    
    // MARK: - Actions
    
   
    
    // MARK: - Utility methods
    
    func tvShows() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let urlRequest = "https://tv-shows.infinum.academy/shows"
        AF
          .request(
              urlRequest,
              method: HTTPMethod.get,
              parameters: ["page": "1", "items": "100"], // pagination arguments
              headers: HTTPHeaders(userHeaders)
          )
          .validate()
            .responseDecodable(of: ShowsResponse.self) { [weak self] response in
                guard let self = self else {return}
                MBProgressHUD.hide(for: self.view, animated: true)
                switch response.result {
                case .success(let shows):
                    print("This is response: \(shows)")
//                    self.tableViewData = shows.shows[$1]
                    
                case .failure(let error):
                    print("Response failed! \(error)")
                }
            
            }
        
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}


