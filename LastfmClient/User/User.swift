//
//  User.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/17.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import Result

public class User {
    public let user: String
    public init(user: String) {
        self.user = user
    }

    public func getInfo(_ handler: @escaping (Result<User.InfoRequest.Response, SessionTaskError>) -> Void) {
        let infoRequest = User.InfoRequest(user: self)
        Session.shared.send(infoRequest) { result in
            handler(result)
        }
    }
}

extension User {
    public struct InfoRequest: LastfmRequest {
        let user: User
        init(user: User) {
            self.user = user
        }

        public typealias Response = Entity.User

        public var method: HTTPMethod {
            return .get
        }

        public var queryParameters: [String: Any]? {
            var q = defaultParameters
            q["method"] = "user.getInfo"
            q["user"] = user.user
            return q
        }
    }
}
