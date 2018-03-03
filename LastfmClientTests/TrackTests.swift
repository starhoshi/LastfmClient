//
//  TrackTests.swift
//  LastfmClientTests
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import XCTest
import APIKit
import LastfmClient

class TrackTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Configuration.shared.configure(apiKey: TestConfiguration.apiKey)
    }

    func testGetInfoWhenExistImage() {
        let expectation = XCTestExpectation(description: "getInfo")

        TrackAPI.getInfo(track: "little my star", artist: "U", username: "star__hoshi", autocorrect: false) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.name, "little my star")
                XCTAssertFalse(response.streamable)
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
}


