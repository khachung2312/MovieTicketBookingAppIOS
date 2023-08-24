//
//  MoviesResponseModel.swift
//  MovieTicketBookingApp
//
//  Created by Lê Đình Linh on 17/08/2023.
//

import Foundation

struct MovieResponse: Codable {
    var message: String
    var isSuccess: Bool
    var data: Movie
}

struct Movie: Codable {
    var id: Int
    var title: String
    var year: Int
    var categories: [Category]
    var thumbnail: String
    var rating: Double
    var duaration: Int
    var directors: [Director]
    var writers: [Writer]
    var pgs: [PG]
    var trailers: [Trailer]
    var producers: [Producer]
    var description: String
}

struct Category: Codable {
    var id: Int
    var name: String
}

struct Director: Codable {
    var id: Int
    var fullName: String
}

struct Writer: Codable {
    var id: Int
    var fullName: String
}

struct PG: Codable {
    var id: Int
    var name: String
}

struct Trailer: Codable {
    var id: Int
    var url: String
    var thumbnail: String
}

struct Producer: Codable {
    var id: Int
    var name: String
}
