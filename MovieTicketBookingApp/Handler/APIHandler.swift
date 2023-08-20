//
//  APIHandler.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 18/08/2023.
//

import Foundation
import Alamofire

class APIHandler{
    
    let URL_getMovieOfAction = "http://146.190.97.170:9923/movies/?typeID=1"
    let URL_getVoucher = "http://146.190.97.170:9923/vouchers"
    
    func getMovies(completion: @escaping(Welcome) -> ()) {
        AF.request(URL_getMovieOfAction, method: .get).responseDecodable(of: Welcome.self) { response in
            switch response.result {
            case .success(let welcome):
                completion(welcome)
                print("Successed Welcome")
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func getVouchers(completion: @escaping(VoucherWelcome) -> ()) {
        AF.request(URL_getVoucher, method: .get).responseDecodable(of: VoucherWelcome.self) { response in
            switch response.result {
            case .success(let welcome):
                completion(welcome)
            case .failure(let error):
                print("Errorrrrrrrrrrrrrrr: \(error)")
            }
        }
    }

}
