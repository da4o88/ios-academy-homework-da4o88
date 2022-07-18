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
        
      // Backround color is #52368C
      //      self.view.backgroundColor = UIColor(red: 82/250.0, green: 54/250.0, blue: 140/250.0, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        //Looks for single or multiple taps.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        roundedButtons()
        
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
    
    // Login and Register Section
    // Login Button Action
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        
        pushToHomeScreen()
    }
    
    // Register Button Action
    
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        
        pushToHomeScreen()
    }
    
    // MARK: - Utility methods
    
    // Create round edges on button
    
    private func roundedButtons() -> Void {
        
        loginButton.layer.cornerRadius = 24
        loginButton.layer.masksToBounds = true
        
    }
    
    // Show-Hide keyboard
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    //Calls this function when the tap is recognized.
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Push to HomeScreen
    
    func pushToHomeScreen() {
        
        let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeViewController
        homeScreen.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(homeScreen, animated: true)
    }
    
    // Validate email and password
    
    // Login User call to API
    
    // Register User call to API
    
}
