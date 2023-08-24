//
//  MovieTheaterModel.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 19/08/2023.
//

import Foundation

struct Theater: Codable {
    let id: Int
    let name: String
    let longitude: Double
    let latitude: Double
    let address: String
}

struct Price: Codable {
    let id: Int
    let name: String
    let price: Int
}

struct Slot: Codable {
    let slotTime: String
    let slotDate: String
    let prices: [Price]
}


struct TheaterData: Codable {
    let theater: Theater
    let availableSlots: [Slot]
}

struct MovieTheaterResponse: Codable {
    let message: String
    let isSuccess: Bool
    let data: [TheaterData]
    
    init(message: String, isSuccess: Bool, data: [TheaterData]) {
        self.message = message
        self.isSuccess = isSuccess
        self.data = data
    }
}
