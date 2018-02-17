//
//  LastfmAPIConfiguration.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/17.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

/// Configuration for Lastfm
public class Configuration {
    public static let shared = Configuration()
    private init() { }

    /// https://www.last.fm/api/account/create
    public var apiKey: String?

    public func configure(apiKey: String) {
        self.apiKey = apiKey
    }
}
