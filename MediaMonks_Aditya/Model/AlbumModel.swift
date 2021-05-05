//
//  AlbumModel.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import Foundation

struct AlbumModel: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
