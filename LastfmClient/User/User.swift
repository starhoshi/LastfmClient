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

struct StringCodableMap<Decoded: LosslessStringConvertible>: Codable {
    var decoded: Decoded

    init(_ decoded: Decoded) {
        self.decoded = decoded
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedString = try container.decode(String.self)

        guard let decoded = Decoded(decodedString) else {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: """
                The string \(decodedString) is not representable as a \(Decoded.self)
                """
            )
        }

        self.decoded = decoded
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(decoded.description)
    }
}

public class Entity {
    public struct User: Decodable {
        public let name: String
        public let realname: String?
        public let url: URL
        public let country: String
        public var age: Int
        public let gender: String
        public let subscriber: Int
        public let playcount: Int
        public let playlists: Int
        public let bootstrap: Int
//        public let registered: Date
//        public let image: Image

        private enum CodingKeys: String, CodingKey {
            case name
            case realname
            case url
            case country
            case age
            case gender
            case subscriber
            case playcount
            case playlists
            case bootstrap
//            case registered
//            case image
        }

        private enum UserKeys: String, CodingKey {
            case user
        }

        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: UserKeys.self)

            let user = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
            name = try user.decode(String.self, forKey: .name)
            realname = try user.decodeIfPresent(String.self, forKey: .realname)
            url = try user.decode(URL.self, forKey: .url)
            country = try user.decode(String.self, forKey: .country)
            age = try user.decode(StringCodableMap<Int>.self, forKey: .age).decoded
            gender = try user.decode(String.self, forKey: .country)
            subscriber = try user.decode(StringCodableMap<Int>.self, forKey: .subscriber).decoded
            playcount = try user.decode(StringCodableMap<Int>.self, forKey: .playcount).decoded
            playlists = try user.decode(StringCodableMap<Int>.self, forKey: .playlists).decoded
            bootstrap = try user.decode(StringCodableMap<Int>.self, forKey: .bootstrap).decoded
        }
    }
}
