//
//  TopTrack.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/25.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct TopTrack: Decodable {
    public let name: String
    public let duration: Int
    public let playcount: Int
    public let mbid: String
    public let url: URL
    public let streamable: Bool
    public let artist: TopArtist
    public let image: Image
    public let rank: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case duration
        case playcount
        case mbid
        case url
        case streamable
        case artist
        case image
        case rank = "@attr"
    }

    private enum StreamableKeys: String, CodingKey {
        case fulltrack
    }

    private enum RankKeys: String, CodingKey {
        case rank
    }

    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        name = try decoder.decode(String.self, forKey: .name)
        duration = try decoder.decode(StringCodableMap<Int>.self, forKey: .duration).decoded
        playcount = try decoder.decode(StringCodableMap<Int>.self, forKey: .playcount).decoded
        mbid = try decoder.decode(String.self, forKey: .mbid)
        url = try decoder.decode(URL.self, forKey: .url)
        let streamableDecoder = try decoder.nestedContainer(keyedBy: StreamableKeys.self, forKey: .streamable)
        streamable = try streamableDecoder.decode(StringCodableMap<Int>.self, forKey: .fulltrack).decoded == 1
        artist = try decoder.decode(TopArtist.self, forKey: .artist)
        image = try decoder.decode(ImageDecodableMap.self, forKey: .image).decoded
        let rankDecoder = try decoder.nestedContainer(keyedBy: RankKeys.self, forKey: .rank)
        rank = try rankDecoder.decode(StringCodableMap<Int>.self, forKey: .rank).decoded
    }
}

public struct TopArtist: Decodable {
    public let name: String
    public let mbid: String
    public let url: URL

    private enum CodingKeys: String, CodingKey {
        case name
        case mbid
        case url
    }

    public init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)

        name = try decoder.decode(String.self, forKey: .name)
        mbid = try decoder.decode(String.self, forKey: .mbid)
        url = try decoder.decode(URL.self, forKey: .url)
    }
}

