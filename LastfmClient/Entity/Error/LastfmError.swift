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
        /// 1 : This error does not exist
        case notExist1 = 1
        /// 2 : Invalid service -This service does not exist
        case invalidService = 2
        /// 3 : Invalid Method - No method with that name in this package
        case invalidMethod = 3
        /// 4 : Authentication Failed - You do not have permissions to access the service
        case authenticationFailed = 4
        /// 5 : Invalid format - This service doesn't exist in that format
        case invalidFormat = 5
        /// 6 : Invalid parameters - Your request is missing a required parameter
        case invalidParameters = 6
        /// 7 : Invalid resource specified
        case invalidResourceSpecified = 7
        /// 8 : Operation failed - Most likely the backend service failed. Please try again.
        case operationFailed = 8
        /// 9 : Invalid session key - Please re-authenticate
        case invalidSessionKey = 9
        /// 10 : Invalid API key - You must be granted a valid key by last.fm
        case invalidAPIKey = 10
        /// 11 : Service Offline - This service is temporarily offline. Try again later.
        case serviceOffline = 11
        /// 12 : Subscribers Only - This station is only available to paid last.fm subscribers
        case subscribersOnly = 12
        /// 13 : Invalid method signature supplied
        case invalidMethodSignatureSupplied = 13
        /// 14 : Unauthorized Token - This token has not been authorized
        case unauthorizedToken = 14
        /// 15 : This item is not available for streaming.
        case notAvailableForStreaming = 15
        /// 16 : The service is temporarily unavailable, please try again.
        case temporarilyUnavailable = 16
        /// 17 : Login: User requires to be logged in
        case userRequiresToBeLoggedIn = 17
        /// 18 : Trial Expired - This user has no free radio plays left. Subscription required.
        case trialExpired = 18
        /// 19 : This error does not exist
        case notExist19 = 19
        /// 20 : Not Enough Content - There is not enough content to play this station
        case notEnoughContent = 20
        /// 21 : Not Enough Members - This group does not have enough members for radio
        case notEnoughMembers = 21
        /// 22 : Not Enough Fans - This artist does not have enough fans for for radio
        case notEnoughFans = 22
        /// 23 : Not Enough Neighbours - There are not enough neighbours for radio
        case notEnoughNeighbours = 23
        /// 24 : No Peak Radio - This user is not allowed to listen to radio during peak usage
        case noPeakRadio = 24
        /// 25 : Radio Not Found - Radio station not found
        case radioNotFound = 25
        /// 26 : API Key Suspended - This application is not allowed to make requests to the web services
        case apiKeySuspended = 26
        /// 27 : Deprecated - This type of request is no longer supported
        case deprecated = 27
        /// 29 : Rate Limit Exceded - Your IP has made too many requests in a short period, exceeding our API guidelines
        case rateLimitExcededcase = 29
    }
}
