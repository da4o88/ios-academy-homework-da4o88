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
    
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
    }

    

}

extension ReviewViewController {
    
    @IBAction func backButton(sender: UIButton) {
        navigationController?.popViewController(animated: true)
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


