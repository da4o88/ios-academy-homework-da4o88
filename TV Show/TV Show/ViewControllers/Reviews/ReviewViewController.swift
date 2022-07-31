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
    
    
    @IBOutlet weak var tableReview: UITableView!
    @IBOutlet weak var closeBackButton: UIBarButtonItem!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        closeBackButton.title = "Close"
        
        
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
