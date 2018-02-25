//
//  ListResponse.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/25.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation

public protocol ListResponse {
    associatedtype List

    var list: [List] { get }
    var attr: Attr { get }
}
