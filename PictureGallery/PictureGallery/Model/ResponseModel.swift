//
//  ResponseModel.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    let pictureCollectionTitle: String?
    var photos: [Photos]?

    enum CodingKeys: String, CodingKey {
        case pictureCollectionTitle = "title"
        case photos = "rows"
    }
}

struct Photos: Codable {
    var title  : String?
    var imageUrl : String?
    var description : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageUrl = "imageHref"
        case description = "description"
    }
}
