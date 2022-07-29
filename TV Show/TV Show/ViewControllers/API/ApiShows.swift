//
//  ApiShows.swift
//  TV Show
//
//  Created by infinum on 24/07/2022.
//

import Foundation

// MARK: - Shows

struct ShowsResponse: Decodable {
    let shows: [Show]
}

struct Show: Decodable {
    let id: String
    let averageRating: Double?
    let description: String?
    let imageUrl: String?
    let numOfReviews: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case averageRating = "average_rating"
        case description = "description"
        case imageUrl = "image_url"
        case numOfReviews = "no_of_reviews"
        case title = "title"
    }
}
