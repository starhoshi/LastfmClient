//
//  Entity.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/17.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public class Entity {}

extension Entity {
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
