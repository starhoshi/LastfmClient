//
//  Image.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/03.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct Image: Decodable {
    public let small: URL?
    public let medium: URL?
    public let large: URL?
    public let extralarge: URL?
}
