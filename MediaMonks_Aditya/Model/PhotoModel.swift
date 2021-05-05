//
//  PhotoModel.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import Foundation

struct PhotoModel: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
