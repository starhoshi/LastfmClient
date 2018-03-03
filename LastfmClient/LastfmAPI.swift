//
//  LastfmAPI.swift
//  LastfmClient
//
//  Created by kensuke-hoshikawa on 2018/02/17.
//  Copyright © 2018年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import Result

/// https://www.last.fm/api
public protocol LastfmRequest: Request {
}

extension LastfmRequest {
    public var baseURL: URL {
        return URL(string: "https://ws.audioscrobbler.com/2.0")!
    }

    public var key: String {
        guard let apiKey = Configuration.shared.apiKey else {
            fatalError("API key must be set! https://www.last.fm/api/account/create")
        }
        return apiKey
    }

    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public var defaultParameters: [String: Any] {
        var query = ["api_key": key]
        query["format"] = "json"
        return query
    }

    public var path: String {
        return "/"
    }
}

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        return data
    }
}

extension LastfmRequest where Response: Decodable {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data: Data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
//        if let string = String(data: data, encoding: .utf8) {
//            print("response: \(string)")
//        }
        if let lastfmError = try? JSONDecoder().decode(LastfmError.self, from: data) {
            throw lastfmError
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

extension LastfmRequest {
    public func intercept(urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.timeoutInterval = 10.0

//        print("requestURL: \(urlRequest)")
//        print("requestHeader: \(urlRequest.allHTTPHeaderFields!)")
//        print("requestBody: \(String(data: urlRequest.httpBody ?? Data(), encoding: .utf8).debugDescription)")
        return urlRequest
    }

    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
//        print("raw response header: \(urlResponse)")
//        print("raw response body: \(object)")
        switch urlResponse.statusCode {
        case 200..<300:
            return object

        default:
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
    }
}
