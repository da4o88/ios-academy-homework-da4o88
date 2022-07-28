//
//  ReviewViewController.swift
//  TV Show
//
//  Created by infinum on 27/07/2022.
//

import Foundation
import UIKit

class ReviewViewController: UIViewController {
    
   
    
    // MARK: - Outlets
   

    
    // MARK: - Properties


    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "Write a Review"
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
//
//}
//
//extension ReviewViewController {
//
//
//}
