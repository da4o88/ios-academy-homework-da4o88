//
//  API_User.swift
//  TV Show
//
//  Created by infinum on 18/07/2022.
//

import Foundation
import UIKit

// User Info
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
