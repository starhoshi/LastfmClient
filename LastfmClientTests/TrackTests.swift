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

        TrackAPI.getInfo(track: "little my star", artist: "U", autocorrect: false) { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.name, "RJ")
                XCTAssertEqual(user.realname, "Richard Jones ")
                XCTAssertEqual(user.image.small?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/34s/b26d6fd11de240a1c045dfb5c5d9fe65.png")
                XCTAssertEqual(user.image.medium?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/64s/b26d6fd11de240a1c045dfb5c5d9fe65.png")
                XCTAssertEqual(user.image.large?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/174s/b26d6fd11de240a1c045dfb5c5d9fe65.png")
                XCTAssertEqual(user.image.extralarge?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/300x300/b26d6fd11de240a1c045dfb5c5d9fe65.png")
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
}
