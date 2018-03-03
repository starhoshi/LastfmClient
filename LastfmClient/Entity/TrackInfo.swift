//
//  TrackInfo.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct Tag: Decodable {
    public let name: String
    public let url: URL
}

public struct Wiki: Decodable {
    public let published: String
    public let summary: String
    public let content: String
}

public struct Album: Decodable {
    public let artist: String
    public let title: String
    public let mbid: String
    public let url: URL
    public let image: Image
    public let position: Int

    private enum CodingKeys: String, CodingKey {
        case artist
        case title
        case mbid
        case url
        case image
        case position = "@attr"
    }

    private enum PositionKeys: String, CodingKey {
        case position
    }


    public init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: CodingKeys.self)

        artist = try root.decode(String.self, forKey: .artist)
        title = try root.decode(String.self, forKey: .title)
        mbid = try root.decode(String.self, forKey: .mbid)
        url = try root.decode(URL.self, forKey: .url)
        image = try root.decode(ImageDecodableMap.self, forKey: .image).decoded

        let position = try root.nestedContainer(keyedBy: PositionKeys.self, forKey: .position)
        self.position = try position.decode(StringCodableMap<Int>.self, forKey: .position).decoded
    }
}

public struct TrackInfo: Decodable {
    public let name: String
    public let url: URL
    public let duration: Int
    public var streamable: Bool
    public let listeners: Int
    public let playcount: Int
    public let artist: Artist
    public let toptags: [Tag]

    public let mbid: String?
    public let album: Album?
    public let userplaycount: Int?
    public let userloved: Bool?
    public let wiki: Wiki?

    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case duration
        case streamable
        case listeners
        case playcount
        case artist
        case toptags
        case mbid
        case album
        case userplaycount
        case userloved
        case wiki
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
        toptags = try root.decode(TagsDecodableMap.self, forKey: .toptags).decoded
        mbid = try root.decodeIfPresent(String.self, forKey: .mbid)
        album = try root.decodeIfPresent(Album.self, forKey: .album)
        userplaycount = try root.decodeIfPresent(StringCodableMap<Int>.self, forKey: .userplaycount)?.decoded
        let userloved = try root.decodeIfPresent(StringCodableMap<Int>.self, forKey: .userloved)?.decoded
        self.userloved = userloved == nil ? nil : userloved == 1
        wiki = try root.decodeIfPresent(Wiki.self, forKey: .wiki)
    }
}
