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
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var showPasswordButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    
    private var checkedButton = false
    private var isPasswordHidden = true
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      // Do any additional setup after loading the view.
      // MBProgressHUD.showAdded(to: view, animated: true)
      //
      // Backround color is #52368C
        
//      self.view.backgroundColor = UIColor(red: 82/250.0, green: 54/250.0, blue: 140/250.0, alpha: 1)

        roundedButtons()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
        
    }
  
    // MARK: - Actions
    
    // Checkbox button for Remember me
    
    @IBAction private func checkButton(_ sender: Any) {
        if (!checkedButton) {
            
            checkBoxButton.setImage(UIImage (named: "ic-checkbox-selected"), for: .normal)
            checkedButton = true
            
        } else {
            
            checkBoxButton.setImage(UIImage (named: "ic-checkbox-unselected"), for: .normal)
            checkedButton = false
        }
        
    }
    
    // Show - Hide password
    
    @IBAction func showPassword(_ sender: Any) {
        
        if isPasswordHidden {
            
            showPasswordButton.setImage(UIImage (named: "ic-invisible"), for: .normal)
            isPasswordHidden = false
            passwordTextField.isSecureTextEntry = false
            
        } else {
            
            showPasswordButton.setImage(UIImage (named: "ic-visible"), for: .normal)
            isPasswordHidden = true
            passwordTextField.isSecureTextEntry = true
            
        }
    }
    
    //MARK: Utility methods
    
    // Create round edges on button
    
    private func roundedButtons() -> Void {
        
        loginButton.layer.cornerRadius = 24
        loginButton.layer.masksToBounds = true
        
    }
    
}
