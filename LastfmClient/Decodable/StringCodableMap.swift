//
//  StringCodableMap.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/17.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

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

struct RegisteredDecodableMap: Decodable {
    var decoded: Date

    enum Registered: String, CodingKey {
        case text = "#text"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Registered.self)
        let time = try container.decode(Double.self, forKey: .text)
        let decoded = Date(timeIntervalSince1970: time)
        self.decoded = decoded
    }
}

struct ImageDecodableMap: Decodable {
    var decoded: Entity.Image

    enum Size: String, Codable {
        case small
        case medium
        case large
        case extralarge
    }

    struct _Image: Decodable {
        let text: String
        let size: Size

        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case size
        }
    }

    init(from decoder: Decoder) throws {
        var images: [_Image] = []
        var unkeyedContainer = try decoder.unkeyedContainer()
        while !unkeyedContainer.isAtEnd {
            let image = try unkeyedContainer.decode(_Image.self)
            images.append(image)
        }
        var small: URL?
        var medium: URL?
        var large: URL?
        var extralarge: URL?
        images.forEach { img in
            let url = URL(string: img.text)
            switch img.size {
            case .small:
                small = url
            case .medium:
                medium = url
            case .large:
                large = url
            case .extralarge:
                extralarge = url
            }
        }

        self.decoded = Entity.Image(small: small, medium: medium, large: large, extralarge: extralarge)
    }
}
