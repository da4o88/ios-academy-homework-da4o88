//
//  ApiReviews.swift
//  TV Show
//
//  Created by infinum on 29/07/2022.
//

import Foundation

// MARK: - Reviews

struct ReviewResponse: Decodable {
    let reviews: [Review]
}

struct Review: Decodable {
    let id: String
    let comment: String
    let rating: Int
    let showId: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case comment
        case rating 
        case showId = "show_id"
        case user 
    }
}
