//
//  LastfmError.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/03/01.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public struct LastfmError: Error, Decodable {
    public let error: Code
    public let message: String

    public enum Code: Int, Decodable, Equatable {
        case notExist = 1
        case invalidParameters = 6
    }
}
