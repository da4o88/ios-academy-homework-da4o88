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
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
   
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties

    var userHeaders: [String: String] = [:]
    var tableViewData: [Show] = []
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Shows"
        self.navigationItem.setHidesBackButton(true, animated: true)
        tvShows()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

extension HomeViewController {
    
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
                case .success(let tvShows):
                    self.tableViewData = tvShows.shows
                    self.tableView.reloadData()
                    print("news: \(tvShows.shows)")
                case .failure(let error):
                    print("Response failed! \(error)")
                }
            
            }
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TvShowsTableViewCell.self), for: indexPath) as! TvShowsTableViewCell
        let data = tableViewData[indexPath.row]
        let url = URL(string: data.imageUrl!)
        cell.showImage.kf.setImage(with: url)
        cell.titleLabel.text = data.title
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected cell at \(indexPath.row)")
    }
}

