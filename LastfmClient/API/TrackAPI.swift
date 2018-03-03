//
//  TrackAPI.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import Result

public class TrackAPI {
    /// mbid (Optional) : The musicbrainz id for the track
    /// track (Required (unless mbid)] : The track name
    /// artist (Required (unless mbid)] : The artist name
    /// username (Optional) : The username for the context of the request. If supplied, the user's playcount for this track and whether they have loved the track is included in the response.
    /// autocorrect[0|1] (Optional) : Transform misspelled artist and track names into correct artist and track names, returning the correct version instead. The corrected artist and track name will be returned in the response.
    public static func getInfo(mbid: String? = nil, track: String? = nil, artist: String? = nil, username: String? = nil, autocorrect: Bool = false, _ handler: @escaping (Result<User, SessionTaskError>) -> Void) {
        let request = TrackAPI.InfoRequest(mbid: mbid, track: track, artist: artist, username: username, autocorrect: autocorrect)
        Session.shared.send(request) { result in
            handler(result)
        }
    }
}

extension TrackAPI {
    struct InfoRequest: LastfmRequest {
        let mbid: String?
        let track: String?
        let artist: String?
        let username: String?
        let autocorrect: Bool
        init(mbid: String?, track: String?, artist: String?, username: String?, autocorrect: Bool) {
            self.mbid = mbid
            self.track = track
            self.artist = artist
            self.username = username
            self.autocorrect = autocorrect
        }

        typealias Response = User

        var method: HTTPMethod {
            return .get
        }

        var queryParameters: [String: Any]? {
            var q = defaultParameters
            q["method"] = "track.getInfo"
            if let mbid = mbid { q["mbid"] = mbid }
            if let track = track { q["track"] = track }
            if let artist = artist { q["artist"] = artist }
            if let username = username { q["username"] = username }
            q["autocorrect"] = autocorrect ? 1 : 0
            return q
        }
    }
}


