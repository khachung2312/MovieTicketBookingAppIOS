//
//  MovieModel.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 11/08/2023.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let message: String
    let isSuccess: Bool
    let data: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case message
        case isSuccess
        case data
    }
}


// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let title: String
    let year: Int
    let categories: [Category]
    let thumbnail: String
    let rating: Double
    let duaration: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case year
        case categories
        case thumbnail
        case rating
        case duaration
    }
}


// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

typealias MovieTypelias = [Movie]
typealias CategoryTypelias = [Category]
