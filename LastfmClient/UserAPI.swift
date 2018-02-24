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
    public let user: String?

    /// Initializer
    ///
    /// - Parameter user: username
    public init(user: String?) {
        self.user = user
    }

    public typealias GetInfoResponse = User
    /// Get information about a user profile.
    /// [https://www.last.fm/api/show/user.getInfo](https://www.last.fm/api/show/user.getInfo)
    public func getInfo(_ handler: @escaping (Result<GetInfoResponse, SessionTaskError>) -> Void) {
        let infoRequest = UserAPI.InfoRequest(user: user)
        Session.shared.send(infoRequest) { result in
            handler(result)
        }
    }

    /// Get a list of the recent tracks listened to by this user. Also includes the currently playing track with the nowplaying="true" attribute if the user is currently listening.
    /// [https://www.last.fm/api/show/user.getRecentTracks](https://www.last.fm/api/show/user.getRecentTracks)
    public func getRecentTracks(user: String? = nil, limit: Int = 50, page: Int = 1, from: TimeInterval = 0, extended: Bool = true, to: TimeInterval = Date().timeIntervalSince1970, _ handler: @escaping (Result<RecentTracksResponse, SessionTaskError>) -> Void) {
        let username = user ?? self.user ?? ""
        let infoRequest = UserAPI.RecentTracksRequest(user: username, limit: limit, page: page, from: from, extended: extended, to: to)
        Session.shared.send(infoRequest) { result in
            handler(result)
        }
    }
}

extension UserAPI {
    struct InfoRequest: LastfmRequest {
        let user: String?
        init(user: String?) {
            self.user = user
        }

        typealias Response = GetInfoResponse

        var method: HTTPMethod {
            return .get
        }

        var queryParameters: [String: Any]? {
            var q = defaultParameters
            q["method"] = "user.getInfo"
            q["user"] = user ?? ""
            return q
        }
    }

    struct RecentTracksRequest: LastfmRequest {
        /// user (Required) : The last.fm username to fetch the recent tracks of.
        let user: String
        /// limit (Optional) : The number of results to fetch per page. Defaults to 50. Maximum is 200.
        let limit: Int
        /// page (Optional) : The page number to fetch. Defaults to first page.
        let page: Int
        /// from (Optional) : Beginning timestamp of a range - only display scrobbles after this time, in UNIX timestamp format (integer number of seconds since 00:00:00, January 1st 1970 UTC). This must be in the UTC time zone.
        let from: TimeInterval
        /// extended (0|1) (Optional) : Includes extended data in each artist, and whether or not the user has loved each track
        let extended: Bool
        /// to (Optional) : End timestamp of a range - only display scrobbles before this time, in UNIX timestamp format (integer number of seconds since 00:00:00, January 1st 1970 UTC). This must be in the UTC time zone.
        let to: TimeInterval
        init(user: String, limit: Int, page: Int, from: TimeInterval, extended: Bool, to: TimeInterval) {
            self.user = user
            self.limit = limit
            self.page = page
            self.from = from
            self.extended = extended
            self.to = to
        }

        typealias Response = RecentTracksResponse

        var method: HTTPMethod {
            return .get
        }

        var queryParameters: [String: Any]? {
            var q = defaultParameters
            q["method"] = "user.getRecentTracks"
            q["user"] = user
            q["limit"] = limit
            q["page"] = page
            q["from"] = from
            q["extended"] = extended ? 1 : 0
            q["to"] = to
            return q
        }
    }

    public struct RecentTracksResponse: ListResponse, Decodable {
        public typealias List = Track
        public let list: [List]
        public let attr: Attr

        private enum CodingKeys: String, CodingKey {
            case list
            case attr
        }

        private enum RecentTracksKeys: String, CodingKey {
            case recenttracks
        }

        private enum TrackAttrKeys: String, CodingKey {
            case track
            case attr = "@attr"
        }



        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: RecentTracksKeys.self)
            let recentTracks = try values.nestedContainer(keyedBy: TrackAttrKeys.self, forKey: .recenttracks)
            self.attr = try recentTracks.decode(Attr.self, forKey: .attr)
            self.list = []
//            let attr = try attrTracks.nestedContainer(keyedBy: TrackAttrKeys.self, forKey: .attr)

//            let tracks = try recentTracks.(keyedBy: TrackKeys.self)
//            let user = try attr.decode(, forKey: <#T##Attr.CodingKeys#>)

//            name = try decoder.decode(String.self, forKey: .name)
        }


    }

}

