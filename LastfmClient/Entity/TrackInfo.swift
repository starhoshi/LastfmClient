//
//  TrackInfo.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct TrackInfo: Decodable {
    public let name: String
    public let url: URL
    public let duration: Int
    public var streamable: Bool
    public let listeners: Int
    public let playcount: Int
    public let artist: Artist
//    public let toptags: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case duration
        case streamable
        case listeners
        case playcount
        case artist
//        case toptags
    }

    private enum TrackKeys: String, CodingKey {
        case track
    }

    private enum StreamableKeys: String, CodingKey {
        case fulltrack
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: TrackKeys.self)

        let root = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .track)
        name = try root.decode(String.self, forKey: .name)
        url = try root.decode(URL.self, forKey: .url)
        duration = try root.decode(StringCodableMap<Int>.self, forKey: .duration).decoded
        streamable = try root.decode(StreamableDecodableMap.self, forKey: .streamable).decoded
        listeners = try root.decode(StringCodableMap<Int>.self, forKey: .listeners).decoded
        playcount = try root.decode(StringCodableMap<Int>.self, forKey: .playcount).decoded
        artist = try root.decode(Artist.self, forKey: .artist)
//        toptags = try user.decode(StringCodableMap<Int>.self, forKey: .bootstrap).decoded
    }
}

//{
//    track: {
//        name: "宙船",
//        url: "https://www.last.fm/music/TOKIO/_/%E5%AE%99%E8%88%B9",
//        duration: "0",
//        streamable: {
//            #text: "0",
//            fulltrack: "0"
//        },
//        listeners: "2872",
//        playcount: "28824",
//        artist: {
//            name: "TOKIO",
//            mbid: "d210bd3e-68db-4987-a714-0214449e361d",
//            url: "https://www.last.fm/music/TOKIO"
//        },
//        toptags: {
//            tag: [
//            {
//            name: "j-pop",
//            url: "https://www.last.fm/tag/j-pop"
//            },
//            {
//            name: "rock",
//            url: "https://www.last.fm/tag/rock"
//            },
//            {
//            name: "pop",
//            url: "https://www.last.fm/tag/pop"
//            },
//            {
//            name: "JPop",
//            url: "https://www.last.fm/tag/JPop"
//            },
//            {
//            name: "freaking awesome",
//            url: "https://www.last.fm/tag/freaking+awesome"
//            }
//            ]
//        }
//    }
//}

