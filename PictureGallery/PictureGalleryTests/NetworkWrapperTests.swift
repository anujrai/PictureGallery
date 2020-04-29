//
//  NetworkWrapperTests.swift
//  PictureGalleryTests
//
//  Created by Anuj Rai on 30/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import XCTest
@testable import PictureGallery
class NetworkWrapperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testfetchPhotosFromCorrectURL() {
        
        class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
            func resume() {}
            func cancel() {}
        }
        
        class URLSessionMock: URLSessionProtocol {
            var lastUrl: URL?
            
            func dataTask(with url: URL,
                 completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
                self.lastUrl = url
                completionHandler(nil, nil, nil)
                return URLSessionDataTaskMock()
            }
        }
        
        //Given
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Network Operation")
        
        //When
        NetworkWrapper.sharedInstance.fetchMembers(for: url, using: session) { (result: Result<ResponseModel, Error>) in
          
            //Then
            XCTAssertEqual(session.lastUrl, URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}
