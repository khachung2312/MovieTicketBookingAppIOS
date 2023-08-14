//
//  MovieModel.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 11/08/2023.
//

import Foundation

struct MoviesModel: Codable {
    var movieID: String
    var movieName: String
    var moviePoster: String
    var categoryID: String
    var time: String
    var rating: Int
    
    init(movieID: String, movieName: String, moviePoster: String, categoryID: String, time: String, rating: Int) {
        self.movieID = movieID
        self.movieName = movieName
        self.moviePoster = moviePoster
        self.categoryID = categoryID
        self.time = time
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey{
        case movieID = "movieID"
        case movieName = "movieName"
        case moviePoster = "moviePoster"
        case categoryID = "categoryID"
        case time = "time"
        case rating = "rating"
    }
    
}

typealias MoviesTypealias = [MoviesModel]
