//
//  APIHandler.swift
//  MovieTicketBookingApp
//
//  Created by Lê Đình Linh on 16/08/2023.
//

import Foundation
import Alamofire

class APIHandler {
    let movieDataUrl = "http://146.190.97.170:9923/movies/1"

    func getMovie(completion: @escaping (Movie?) -> ()) {
        AF.request(movieDataUrl, method: .get).responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                completion(movieResponse.data)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
