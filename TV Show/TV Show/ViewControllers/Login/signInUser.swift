//
//  signInUser.swift
//  TV Show
//
//  Created by infinum on 20/07/2022.
//

import Foundation
import MBProgressHUD
import Alamofire

extension LoginViewController: UIViewController {
    
    func signIn() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // Alamofire
        
        let parameters: [String: String?] = [
            
            "email": email,
            "password": password
        ]
                
        AF
            .request(
            "https://tv-shows.infinum.academy/users/sign_in",
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
                self.pushToHomeScreen()
                
                // Store data from API respons to variable
                self.userData = userInfo.user
                
                // Additional checks for headers
                
                let headers = response.response?.headers.dictionary ?? [:]
                
                guard let authInfo = try? AuthInfo(headers: headers) else {
                    print("Missing headers")
                            return
                        }
                    print("\(String(describing: self.userData))\n\n\(authInfo)")
               
            case .failure(let error):
                print("API Error ---")
                print("Failure: \(error)")
              
            }
        }
    }
}
