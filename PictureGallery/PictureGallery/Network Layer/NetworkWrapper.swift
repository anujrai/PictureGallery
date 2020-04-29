//
//  Network Wrapper.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import Foundation
import UIKit

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

final class NetworkWrapper {

    static let sharedInstance = NetworkWrapper()
    private init(){}

    func fetchMembers<T: Decodable>(for url: URL,
                                    using session: URLSessionProtocol = URLSession.shared,
                                    result: @escaping (Result<T, Error>) -> Void)
    {
        session.dataTask(with: url) { (data, response, error) in
            
            //let content = readDummyJSONResponse()!
            DispatchQueue.main.async {
                debugPrint(data)

                guard let content = data, error == nil else {
                    debugPrint(error.debugDescription)
                    result(.failure(DataFetchingError.badResponse))
                    return
                }
                
                let utf8Data = String(decoding: content, as: UTF8.self).data(using: .utf8)

                do {
                   // let content = self.readDummyJSONResponse()!
                    let responseObject = try JSONDecoder().decode(T.self, from: utf8Data!)
                    result(.success(responseObject))
                } catch { let error = error as NSError
                    debugPrint(error.userInfo.debugDescription)
                    debugPrint(DataFetchingError.badResponse.errorDescription!)
                    result(.failure(DataFetchingError.badResponse))
                    return
                }
            }
        }.resume()
    }
    
    private func readDummyJSONResponse() -> Data? {
        guard let jsonURL = Bundle.main.url(forResource: "Photos", withExtension: "json") else {
            return nil
        }
        return try! Data(contentsOf: jsonURL)
    }
}


