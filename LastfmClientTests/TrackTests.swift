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

    func testGetInfoWhenInformationIsMax() {
        let expectation = XCTestExpectation(description: "getInfo")

        TrackAPI.getInfo(track: "being", artist: "KOTOKO", username: "star__hoshi", autocorrect: false) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.name, "being")
                XCTAssertEqual(response.album?.position, 1)
                XCTAssertFalse(response.streamable)
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testGetInfoWhenSmap() {
        let expectation = XCTestExpectation(description: "getInfo")

        TrackAPI.getInfo(track: "世界に一つだけの花", artist: "SMAP", autocorrect: false) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.name, "世界に一つだけの花")
                XCTAssertEqual(response.album?.position, 3)
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testGetInfoWhenInformationIsMinimum() {
        let expectation = XCTestExpectation(description: "getInfo")

        TrackAPI.getInfo(track: "宙船", artist: "TOKIO", autocorrect: true) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.name, "宙船")
                XCTAssertFalse(response.streamable)
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
}
