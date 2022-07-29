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
    @IBOutlet private weak var showPasswordButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    
    private var checkedButton = false
    private var isPasswordHidden = true
    private var emailPassFieldEmpty = true
    private var email = ""
    private var password = ""
//    private var userData: User? = nil
//    var headers: [String: String] = [:]
     let instance = AuthInfoData.shared
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showHideKeyboard()
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        roundedButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Actions
    
    // Checkbox button for Remember me
    @IBAction private func checkButton(_ sender: Any) {
        if checkedButton {
            checkBoxButton.setImage(UIImage (named: "ic-checkbox-unselected"), for: .normal)
            checkedButton = false
        } else {
            checkBoxButton.setImage(UIImage (named: "ic-checkbox-selected"), for: .normal)
            checkedButton = true
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
    @IBAction func didTapLoginButton(_ sender: Any) {
        validateEmailPassword()
        if !emailPassFieldEmpty {
            signIn()
        }
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        validateEmailPassword()
        if !emailPassFieldEmpty {
            registerUser()
        }
    }
    

}

extension LoginViewController {
    
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
        view.endEditing(true)
    }
    
    // Push to HomeScreenController
    func pushToHomeScreen() {
        let homeScreen = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeViewController
        homeScreen.navigationItem.largeTitleDisplayMode = .never
//        homeScreen.userHeaders = headers
        self.navigationController?.pushViewController(homeScreen, animated: true)
        
    }
    
    // Show-Hide Keyboard
    func showHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Validate email and password
    func validateEmailPassword() {
        guard
            let emailText = emailTextField.text,
            let passwordText = passwordTextField.text else { return }
        email = emailText
        password = passwordText
        
        if !email.isEmpty && !password.isEmpty {
            emailPassFieldEmpty = false
        } else {
            emailPassFieldEmpty = true
        }
    }
}

extension LoginViewController {
    
    // MARK: - API requests
    
    func signIn() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let requestUrl = "https://tv-shows.infinum.academy/users/sign_in"
        let parameters: [String: String?] = [
            "email": email,
            "password": password
        ]

        AF
            .request(
            requestUrl,
            method: HTTPMethod.post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: UserResponse.self) { [weak self] response in
            guard let self = self else {return}
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response.result {
            case .success(let userInfo):
                // Store data from API response to variable
                self.instance.user = userInfo.user
                let headers = response.response?.headers.dictionary ?? [:]
                self.handleSuccesfulLogin(for: userInfo.user, headers: headers)
                self.pushToHomeScreen()
            case .failure(let error):
                print("API Error ---")
                print("Failure: \(error)")
                let message = "Login failed. Try again!"
                self.alertMessage(message: message)
            }
        }
    }
    
// Headers will be used for subsequent authorization on next requests
    public func handleSuccesfulLogin(for user: User, headers: [String: String]) {
        guard let authInfo = try? AuthInfo(headers: headers) else {
            print("Missing Headers")
            return
        }
//            print("\(user)\n\n\(authInfo)")
        instance.user = user
        instance.authInfo = authInfo
        
        print("user i headers: \(String(describing:instance.user)) ^^^^^ \(String(describing: instance.authInfo))")
//        instance.authInfo = authInfo.headers
    }
    
    func registerUser() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let userRegisterUrl = "https://tv-shows.infinum.academy/users"
        let parameters: [String: String?] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
                
        AF
            .request(
            userRegisterUrl,
            method: HTTPMethod.post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: UserResponse.self) { [weak self] response in
            guard let self = self else {return}
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response.result {
            case .success(let userInfo):
                self.instance.user = userInfo.user
                let headers = response.response?.headers.dictionary ?? [:]
                self.handleSuccesfulLogin(for: userInfo.user, headers: headers)
                self.pushToHomeScreen()
            case .failure(let error):
                print("API Error ---")
                print("Failure: \(error)")
                let message = "Register failed. Try again!"
                self.alertMessage(message: message)
              
            }
        }
    }
    
    // Login or Register Alert when failed.
    func alertMessage(message: String?) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated:true) {
            return
        }
    }
}
