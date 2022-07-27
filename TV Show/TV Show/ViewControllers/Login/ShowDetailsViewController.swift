//
//  ShowDetailsViewController.swift
//  TV Show
//
//  Created by infinum on 27/07/2022.
//

import Foundation
import UIKit

class ShowDetailsViewController: UIViewController {
    
    // MARK: - Outlets
   
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties


    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}



extension ShowDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // pass info for show
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShowTableViewCell.self), for: indexPath) as! ShowTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Add what is needed to return
        return 1
    }
}

extension ShowDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Change to dynamic
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected shows")
    }
}
