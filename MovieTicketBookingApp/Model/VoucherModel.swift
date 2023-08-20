//
//  VoucherModel.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 19/08/2023.
//

import Foundation

struct VoucherWelcome: Codable {
    let message: String
    let isSuccess: Bool
    let data: [Voucher]
    
    enum CodingKeys: String, CodingKey {
        case message
        case isSuccess
        case data
    }
}

struct Voucher: Codable {
    let id: Int
    let discount: Int
    let fromDate: String
    let expirationDate: String
    let status: String
    let thumbnail: String
    let content: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case discount
        case fromDate
        case expirationDate
        case status
        case thumbnail
        case content
    }
}

typealias VoucherModelTypelias = [VoucherWelcome]
typealias VoucherTypelias = [Voucher]
