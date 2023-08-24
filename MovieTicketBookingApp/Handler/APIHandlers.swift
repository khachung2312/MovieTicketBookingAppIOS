//
//  APIHandlers.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 19/08/2023.
//

import Foundation
import Alamofire

class APIHandler {
    let BASE_GET_MOVIE_THEATER = "http://146.190.97.170:9923/prices?movieID=1&date=24/08/2023"
    let BASE_GET_MOVIE_THEATER_BY_DATE = "http://146.190.97.170:9923/prices?movieID=1&"
    let BASE_GET_SEATS = "http://146.190.97.170:9923/seats?movieID=1&theaterID=1&date=24/08/2023&slotTime=18:00"
    let BASE_POST_TICKET = "http://146.190.97.170:9923/tickets"
    
    func getMovieTheaters(completion: @escaping (MovieTheaterResponse) -> Void) {
        if let url = URL(string: "\(BASE_GET_MOVIE_THEATER)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {

                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movieTheaterResponse = try decoder.decode(MovieTheaterResponse.self, from: data)
                        completion(movieTheaterResponse)
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
            }
            
            task.resume()
        }
    }

    func getSeats(completion: @escaping (SeatingData) -> Void) {
        AF.request("\(BASE_GET_SEATS)", method: .get).responseDecodable(of: SeatingData.self) { response in
            switch response.result {
            case .success(let seatsResponse):
                completion(seatsResponse)
            case .failure(let error):
                print("Error retrieving seats: \(error)")
            }
        }
    }
    
    
    func getMovieTheatersByDate(date: String, completion: @escaping (MovieTheaterResponse) -> Void) {
        let urlString = "\(BASE_GET_MOVIE_THEATER_BY_DATE)date=\(date)"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movieTheaterResponse = try decoder.decode(MovieTheaterResponse.self, from: data)
                        completion(movieTheaterResponse)
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func postMovieBooking(_movieBooking: MovieBooking, completion: @escaping (Bool) -> ()) {
        let parameters: [String: Any] = [
            "movieID": _movieBooking.movieID,
            "theaterID": _movieBooking.theaterID,
            "date": _movieBooking.date,
            "slotTime": _movieBooking.slotTime,
            "bookedSeats": _movieBooking.bookedSeats.map { [
                "rowID": $0.rowID,
                "rowCode": $0.rowCode,
                "seatID": $0.seatID,
                "seatCode": $0.seatCode
            ] as [String : Any]}
        ]
        
        AF.request(BASE_POST_TICKET, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            if response.error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    
}

