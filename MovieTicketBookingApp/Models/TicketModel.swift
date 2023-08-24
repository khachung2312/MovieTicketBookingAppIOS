//
//  TicketModel.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 23/08/2023.
//

import Foundation

struct MovieBooking: Codable {
    let movieID: Int
    let theaterID: Int
    let date: String
    let slotTime: String
    let bookedSeats: [BookedSeat]
}

struct BookedSeat: Codable {
    let rowID: Int
    let rowCode: String
    let seatID: Int
    let seatCode: String
}
