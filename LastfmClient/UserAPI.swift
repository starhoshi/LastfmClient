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

    /// Get information about a user profile.
    /// [https://www.last.fm/api/show/user.getInfo](https://www.last.fm/api/show/user.getInfo)
    public func getInfo(user: String? = nil, _ handler: @escaping (Result<User, SessionTaskError>) -> Void) {
        let username = user ?? self.user ?? ""
        let request = UserAPI.InfoRequest(user: username)
        Session.shared.send(request) { result in
            handler(result)
        }
    }


    /// Get a list of the recent tracks listened to by this user. Also includes the currently playing track with the nowplaying="true" attribute if the user is currently listening.
    /// [https://www.last.fm/api/show/user.getRecentTracks](https://www.last.fm/api/show/user.getRecentTracks)
    ///
    /// - Parameters:
    ///   - user: user (Required) : The last.fm username to fetch the recent tracks of.
    ///   - limit: limit (Optional) : The number of results to fetch per page. Defaults to 50. Maximum is 200.
    ///   - page: page (Optional) : The page number to fetch. Defaults to first page.
    ///   - from: from (Optional) : Beginning timestamp of a range - only display scrobbles after this time, in UNIX timestamp format (integer number of seconds since 00:00:00, January 1st 1970 UTC). This must be in the UTC time zone.
    ///   - to: to (Optional) : End timestamp of a range - only display scrobbles before this time, in UNIX timestamp format (integer number of seconds since 00:00:00, January 1st 1970 UTC). This must be in the UTC time zone.
    ///   - extended: extended (0|1) (Optional) : Includes extended data in each artist, and whether or not the user has loved each track
    ///   - handler: compilation handler
    public func getRecentTracks(user: String? = nil, limit: Int = 50, page: Int = 1, from: TimeInterval = 0, to: TimeInterval = Date().timeIntervalSince1970, extended: Bool = true, _ handler: @escaping (Result<RecentTracksResponse, SessionTaskError>) -> Void) {
        let username = user ?? self.user ?? ""
        let request = UserAPI.RecentTracksRequest(user: username, limit: limit, page: page, from: from, extended: extended, to: to)
        Session.shared.send(request) { result in
            handler(result)
        }
    }

    public enum Period: String {
        case overall
        case sevenDay = "7day"
        case oneMonth = "1month"
        case threeMonth = "3month"
        case sixMonth = "6month"
        case twelveMonth = "12month"
    }

    public func getTopTracks(user: String? = nil, limit: Int = 50, page: Int = 1, period: Period = .overall, _ handler: @escaping (Result<TopTracksResponse, SessionTaskError>) -> Void) {
        let username = user ?? self.user ?? ""
        let infoRequest = UserAPI.TopTracks(user: username, limit: limit, page: page, period: period)
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

        typealias Response = User

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
}

extension UserAPI {
    struct TopTracks: LastfmRequest {
        let user: String
        let limit: Int
        let page: Int
        let period: Period
        init(user: String, limit: Int, page: Int, period: Period) {
            self.user = user
            self.limit = limit
            self.page = page
            self.period = period
        }

        typealias Response = TopTracksResponse

        var method: HTTPMethod {
            return .get
        }

        var queryParameters: [String: Any]? {
            var q = defaultParameters
            q["method"] = "user.getTopTracks"
            q["user"] = user
            q["limit"] = limit
            q["page"] = page
            q["period"] = period
            return q
        }
    }

    public struct TopTracksResponse: ListResponse, Decodable {
        public typealias List = TopTrack
        public let list: [List]
        public let attr: Attr

        private enum CodingKeys: String, CodingKey {
            case list
            case attr
        }

        private enum TopTracksKeys: String, CodingKey {
            case toptracks
        }

        private enum TrackAttrKeys: String, CodingKey {
            case track
            case attr = "@attr"
        }

        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: TopTracksKeys.self)
            let recentTracks = try values.nestedContainer(keyedBy: TrackAttrKeys.self, forKey: .toptracks)
            self.attr = try recentTracks.decode(Attr.self, forKey: .attr)
            self.list = try recentTracks.decode([List].self, forKey: .track)
        }
    }
}

extension UserAPI {
    struct RecentTracksRequest: LastfmRequest {
        let user: String
        let limit: Int
        let page: Int
        let from: TimeInterval
        let extended: Bool
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
        public typealias List = RecentTrack
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
            self.list = try recentTracks.decode([List].self, forKey: .track)
        }
    }
}
