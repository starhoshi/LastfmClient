//
//  UserTests.swift
//  LastfmClientTests
//
//  Created by kensuke-hoshikawa on 2018/02/17.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import XCTest
import LastfmClient

class UserTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Configuration.shared.configure(apiKey: TestConfiguration.apiKey)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetInfoWhenNotExistImage() {
        let expectation = XCTestExpectation(description: "getInfo")

        let user = UserAPI(user: "star__hoshi")
        user.getInfo { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.name, "star__hoshi")
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testGetInfoWhenExistImage() {
        let expectation = XCTestExpectation(description: "getInfo")

        let user = UserAPI(user: "rj")
        user.getInfo { result in
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

    func testGetRecentTracksWhenExtendedTrue() {
        let expectation = XCTestExpectation(description: "getRecentTracks")

        let user = UserAPI(user: "star__hoshi")
        user.getRecentTracks(limit: 100, from: 1519052626, to: 1519139026, extended: true) { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.attr.user, "star__hoshi")
                XCTAssertEqual(user.attr.page, 1)
                XCTAssertEqual(user.attr.perPage, 100)
                XCTAssertEqual(user.attr.total, 15)
                XCTAssertEqual(user.attr.totalPages, 1)
                XCTAssertEqual(user.list.count, 15)
                XCTAssertEqual(user.list[0].name, "little my star")
                XCTAssertNil(user.list[0].image.small)
                XCTAssertNil(user.list[0].image.medium)
                XCTAssertNil(user.list[0].image.large)
                XCTAssertNil(user.list[0].image.extralarge)
                XCTAssertFalse(user.list[0].loved!)
                XCTAssertFalse(user.list[0].streamable)
                XCTAssertEqual(user.list[0].url.absoluteString, "https://www.last.fm/music/U/_/little+my+star")
                XCTAssertEqual(user.list[0].date.timeIntervalSince1970, 1519135099)
                XCTAssertEqual(user.list[0].album.text, "魔界天使ジブリール２(フロントウイング)")
                XCTAssertEqual(user.list[0].album.mbid, "")
                XCTAssertEqual(user.list[0].artist.name, "U")
                XCTAssertEqual(user.list[0].artist.mbid, "f068f7a7-8cff-4104-b7a4-60cc2a060f5a")
                XCTAssertEqual(user.list[0].artist.url?.absoluteString, "https://www.last.fm/music/U")
                XCTAssertEqual(user.list[0].artist.image?.small?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/34s/7c22d3dacc4e4a39b24e8d483d5d0e5a.png")
                XCTAssertEqual(user.list[0].artist.image?.medium?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/64s/7c22d3dacc4e4a39b24e8d483d5d0e5a.png")
                XCTAssertEqual(user.list[0].artist.image?.large?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/174s/7c22d3dacc4e4a39b24e8d483d5d0e5a.png")
                XCTAssertEqual(user.list[0].artist.image?.extralarge?.absoluteString, "https://lastfm-img2.akamaized.net/i/u/300x300/7c22d3dacc4e4a39b24e8d483d5d0e5a.png")
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testGetRecentTracksWhenExtendedFalse() {
        let expectation = XCTestExpectation(description: "getRecentTracks")

        let user = UserAPI(user: "star__hoshi")
        user.getRecentTracks(limit: 100, from: 1519052626, to: 1519139026, extended: false) { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.attr.user, "star__hoshi")
                XCTAssertEqual(user.attr.page, 1)
                XCTAssertEqual(user.attr.perPage, 100)
                XCTAssertEqual(user.attr.total, 15)
                XCTAssertEqual(user.attr.totalPages, 1)
                XCTAssertEqual(user.list.count, 15)
                XCTAssertEqual(user.list[0].name, "little my star")
                XCTAssertNil(user.list[0].image.small)
                XCTAssertNil(user.list[0].image.medium)
                XCTAssertNil(user.list[0].image.large)
                XCTAssertNil(user.list[0].image.extralarge)
                XCTAssertNil(user.list[0].loved)
                XCTAssertFalse(user.list[0].streamable)
                XCTAssertEqual(user.list[0].url.absoluteString, "https://www.last.fm/music/U/_/little+my+star")
                XCTAssertEqual(user.list[0].date.timeIntervalSince1970, 1519135099)
                XCTAssertEqual(user.list[0].album.text, "魔界天使ジブリール２(フロントウイング)")
                XCTAssertEqual(user.list[0].album.mbid, "")
                XCTAssertEqual(user.list[0].artist.name, "U")
                XCTAssertEqual(user.list[0].artist.mbid, "f068f7a7-8cff-4104-b7a4-60cc2a060f5a")
                XCTAssertNil(user.list[0].artist.url?.absoluteString)
                XCTAssertNil(user.list[0].artist.image)
            case .failure(let error):
                XCTFail("\(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
}
