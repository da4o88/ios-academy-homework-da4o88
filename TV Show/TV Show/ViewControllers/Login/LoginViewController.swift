//
//  LoginViewController.swift
//  TV Show
//
//  Created by infinum on 08/07/2022.
//
//
//
import UIKit
import MBProgressHUD
import Alamofire

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var checkBoxButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    //MARK: - Properties
    
   private var checkedButton = false
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      // Do any additional setup after loading the view.
      // MBProgressHUD.showAdded(to: view, animated: true)
        
      // Backround color is #52368C
      //self.view.backgroundColor = UIColor(red: 82/250.0, green: 54/250.0, blue: 140/250.0, alpha: 1)
        
        roundedButtons()
        
    }
  
    // MARK: - Actions
    
    @IBAction private func checkButton(_ sender: Any) {
        if (!checkedButton) {
            
            checkBoxButton.setImage(UIImage (named: "ic-checkbox-selected"), for: .normal)
            checkedButton = true
            
        } else {
            
            checkBoxButton.setImage(UIImage (named: "ic-checkbox-unselected"), for: .normal)
            checkedButton = false
        }
        
    }
    
    //MARK: Utility methods
    
    private func roundedButtons() -> Void {
        
        loginButton.layer.cornerRadius = 24
        loginButton.layer.masksToBounds = true
        
    }
    
}
