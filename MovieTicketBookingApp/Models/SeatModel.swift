//
//  SeatModel.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 20/08/2023.
//

import Foundation

struct Seat: Codable {
    let seatID: Int
    let seatCode: String
    let status: String
    let type: String
    let price: Int
}

struct Row: Codable {
    let rowID: Int
    let rowCode: String
    let seats: [Seat]
}

struct SeatingData: Codable {
    let message: String
    let isSuccess: Bool
    let data: [Row]
}
