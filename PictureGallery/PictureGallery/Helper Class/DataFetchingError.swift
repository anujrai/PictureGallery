//
//  DataFetchingError.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import Foundation

enum DataFetchingError: Error {
    case unknown
    case noInternet
    case badResponse
    case noRecords
}

extension DataFetchingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Something went wrong. Please try again later.", comment: "Error")
        case .badResponse:
            return NSLocalizedString("Response is not in appropriate format.", comment: "Bad Response")
        case .noInternet:
            return NSLocalizedString("Please check your internet connection.", comment: "No Internet")
        case .noRecords:
            return NSLocalizedString("No records to show.", comment: "No Records")
        }
    }
}
