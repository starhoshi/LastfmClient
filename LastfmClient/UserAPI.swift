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


/// https://www.last.fm/api - User
public class UserAPI {
    /// user (Optional) : The user to fetch info for. Defaults to the authenticated user.
    public let user: String

    /// Initializer
    ///
    /// - Parameter user: username
    public init(user: String) {
        self.user = user
    }

    public typealias GetInfoResponse = User

    /// Get information about a user profile.
    /// [https://www.last.fm/api/show/user.getInfo](https://www.last.fm/api/show/user.getInfo)
    public func getInfo(_ handler: @escaping (Result<GetInfoResponse, SessionTaskError>) -> Void) {
        let infoRequest = UserAPI.InfoRequest(user: self)
        Session.shared.send(infoRequest) { result in
            handler(result)
        }
    }

    struct InfoRequest: LastfmRequest {
        let user: UserAPI
        init(user: UserAPI) {
            self.user = user
        }

        typealias Response = GetInfoResponse

        var method: HTTPMethod {
            return .get
        }

        var queryParameters: [String: Any]? {
            var q = defaultParameters
            q["method"] = "user.getInfo"
            q["user"] = user.user
            return q
        }
    }
}
