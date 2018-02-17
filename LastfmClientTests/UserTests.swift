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

    func testGetInfo() {
        let expectation = XCTestExpectation(description: "getInfo")

        let user = User(user: "star__hoshi")
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
}
