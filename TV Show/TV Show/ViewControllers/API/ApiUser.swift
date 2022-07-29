//
//  API_User.swift
//  TV Show
//
//  Created by infinum on 18/07/2022.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire

// MARK: - User

struct UserResponse: Decodable {
    let user: User
}

struct User: Decodable {
    let email: String
    let id: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case imageUrl = "image_url"
        case id
    }
}

struct AuthInfo: Codable {
    
//    static let sharedInstance = AuthInfo()
    
    let accessToken: String
    let client: String
    let tokenType: String
    let expiry: String
    let uid: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access-token"
        case client = "client"
        case tokenType = "token-type"
        case expiry = "expiry"
        case uid = "uid"
    }

  // MARK: - Helpers

    init(headers: [String: String]) throws {
        let data = try JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }

    var headers: [String: String] {
            do {
                let data = try JSONEncoder().encode(self)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                return jsonObject as? [String: String] ?? [:]
            } catch {
                return [:]
            }
        }
}

