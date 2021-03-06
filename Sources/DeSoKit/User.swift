//
//  User.swift
//  
//
//  Created by Jacob Davis on 11/7/21.
//

import Foundation

public typealias UsersStatelessRequest = DeSoKit.User.UsersStatelessRequest
public typealias ProfilesRequest = DeSoKit.User.ProfilesRequest
public typealias SingleProfileRequest = DeSoKit.User.SingleProfileRequest
public typealias HODLersRequest = DeSoKit.User.HODLersRequest
public typealias DiamondsRequest = DeSoKit.User.DiamondsRequest
public typealias FollowsStatelessRequest = DeSoKit.User.FollowsStatelessRequest

public typealias UsersStatelessReponse = DeSoKit.User.UsersStatelessResponse
public typealias ProfilesResponse = DeSoKit.User.ProfilesResponse
public typealias ProfileResponse = DeSoKit.User.SingleProfileResponse
public typealias HODLersResponse = DeSoKit.User.HODLersResponse
public typealias DiamondsResponse = DeSoKit.User.DiamondsResponse
public typealias FollowsStatelessResponse = DeSoKit.User.FollowsStatelessResponse

public typealias User = DeSoKit.User.User
public typealias ProfileEntry = DeSoKit.User.ProfileEntry
public typealias BalanceEntry = DeSoKit.User.BalanceEntry

public extension DeSoKit {
    struct User {}
}

// MARK: - Requests

public extension DeSoKit.User {
    
    struct UsersStatelessRequest: DeSoPostRequest {

        // MARK: - Properties
        
        public let publicKeysBase58Check: [String]
        public let skipForLeaderboard: Bool
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-users-stateless")
        }
        
        public init(publicKeysBase58Check: [String], skipForLeaderboard: Bool = false) {
            self.publicKeysBase58Check = publicKeysBase58Check
            self.skipForLeaderboard = skipForLeaderboard
        }
    }
    
    struct ProfilesRequest: DeSoPostRequest {
        
        // MARK: - Enumerations
        
        public enum OrderBy: String, Codable {
            case none = ""
            case influencerStake = "influencer_stake"
            case influencerPostStake = "influencer_post_stake"
            case newestLastPost = "newest_last_post"
            case newestLastComment = "newest_last_comment"
        }
        
        public enum ModerationType: String, Codable {
            case none = ""
            case leaderboard = "leaderboard"
        }
        
        // MARK: - Properties
        
        public let publicKeyBase58Check: String
        public let username: String
        public let usernamePrefix: String
        public let description: String
        public let orderBy: OrderBy
        public let numToFetch: UInt32
        public let readerPublicKeyBase58Check: String
        public let moderationType: ModerationType
        public let fetchUsersThatHODL: Bool
        public let addGlobalFeedBool: Bool
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-profiles")
        }
        
        public init(publicKeyBase58Check: String = "", username: String = "", usernamePrefix: String = "",
                    description: String = "", orderBy: OrderBy = .none, numToFetch: UInt32 = 20, readerPublicKeyBase58Check: String,
                    moderationType: ModerationType = .none, fetchUsersThatHODL: Bool = false, addGlobalFeedBool: Bool = false) {
            self.publicKeyBase58Check = publicKeyBase58Check
            self.username = username
            self.usernamePrefix = usernamePrefix
            self.description = description
            self.orderBy = orderBy
            self.numToFetch = numToFetch
            self.readerPublicKeyBase58Check = readerPublicKeyBase58Check
            self.moderationType = moderationType
            self.fetchUsersThatHODL = fetchUsersThatHODL
            self.addGlobalFeedBool = addGlobalFeedBool
        }
    }
    
    struct SingleProfileRequest: DeSoPostRequest {
        
        // MARK: - Properties

        public let publicKeyBase58Check: String?
        public let username: String?
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-single-profile")
        }
        
        public init(publicKeyBase58Check: String? = "", username: String? = "") {
            self.publicKeyBase58Check = publicKeyBase58Check
            self.username = username
        }
        
    }
    
    struct HODLersRequest: DeSoPostRequest {
        
        // MARK: - Properties

        public let publicKeyBase58Check: String
        public let username: String
        public let lastPublicKeyBase58Check: String
        public let numToFetch: UInt64
        public let fetchHodlings: Bool
        public let fetchAll: Bool
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-hodlers-for-public-key")
        }
        
        public init(publicKeyBase58Check: String = "", username: String = "", lastPublicKeyBase58Check: String = "",
                    numToFetch: UInt64 = 20, fetchHodlings: Bool = false, fetchAll: Bool = false) {
            self.publicKeyBase58Check = publicKeyBase58Check
            self.username = username
            self.lastPublicKeyBase58Check = lastPublicKeyBase58Check
            self.numToFetch = numToFetch
            self.fetchHodlings = fetchHodlings
            self.fetchAll = fetchAll
        }
        
    }
    
    struct DiamondsRequest: DeSoPostRequest {
        
        // MARK: - Properties

        public let publicKeyBase58Check: String
        public let fetchYouDiamonded: Bool
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-diamonds-for-public-key")
        }
        
        public init(publicKeyBase58Check: String, fetchYouDiamonded: Bool) {
            self.publicKeyBase58Check = publicKeyBase58Check
            self.fetchYouDiamonded = fetchYouDiamonded
        }
        
    }
    
    struct FollowsStatelessRequest: DeSoPostRequest {
        
        // MARK: - Properties
        
        public let publicKeyBase58Check: String
        public let username: String
        public let getEntriesFollowingUsername: Bool
        public let lastPublicKeyBase58Check: String
        public let numToFetch: UInt64
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-follows-stateless")
        }
        
        public init(publicKeyBase58Check: String = "", username: String = "",
                    getEntriesFollowingUsername: Bool = false, lastPublicKeyBase58Check: String = "",
                    numToFetch: UInt64 = 20) {
            self.publicKeyBase58Check = publicKeyBase58Check
            self.username = username
            self.getEntriesFollowingUsername = getEntriesFollowingUsername
            self.lastPublicKeyBase58Check = lastPublicKeyBase58Check
            self.numToFetch = numToFetch
        }
    }
    
    struct UserGlobalMetadataRequest { // TODO: Requires identity service
        
    }
    
    struct UpdateUserGlobalMetadataRequest { // TODO: Requires identity service
        
    }
    
    struct NotificationsRequest { // TODO: Requires identity service
        
    }
    
    struct BlockRequest { // TODO: Requires identity service
        
    }
    
}

// MARK: - Responses

public extension DeSoKit.User {
    
    struct UsersStatelessResponse: Codable {
        public let userList: [User]
        public let defaultFeeRateNanosPerKB: UInt64
        public let paramUpdaters: [String: Bool]
    }
    
    struct ProfilesResponse: Codable {
        public let profilesFound: [ProfileEntry]
        public let nextPublicKey: String?
    }
    
    struct SingleProfileResponse: Codable {
        public let profile: ProfileEntry
    }
    
    struct HODLersResponse: Codable {
        public let hodlers: [BalanceEntry]
        public let lastPublicKeyBase58Check: String
    }
    
    struct DiamondsResponse: Codable {
        
        public struct DiamondsSenderSummary: Codable {
            public let senderPublicKeyBase58Check: String
            public let receiverPublicKeyBase58Check: String
            public let totalDiamonds: UInt64
            public let highestDiamondLevel: UInt64
            public let diamondLevelMap: [String: UInt64]
            public let profileEntryResponse: ProfileEntry?
        }
        
        public let diamondSenderSummaryResponses: [DiamondsSenderSummary]
        public let totalDiamonds: UInt64
    }
    
    struct FollowsStatelessResponse: Codable {
        public let publicKeyToProfileEntry: [String: ProfileEntry]
        public let numFollowers: UInt64
    }
    
}

// MARK: - Models
public extension DeSoKit.User {
    
    struct User: DeSoAvatar, Codable, Identifiable {
        
        // MARK: - Enumerations
        
        public enum TutorialStatus: String, Codable {
            case empty = ""
            case started = "TutorialStarted"
            case skipped = "TutorialSkipped"
            case investOthersBuy = "InvestInOthersBuyComplete"
            case investOthersSell = "InvestInOthersSellComplete"
            case createProfile = "TutorialCreateProfileComplete"
            case investSelf = "InvestInYourselfComplete"
            case followCreators = "FollowCreatorsComplete"
            case diamond = "GiveADiamondComplete"
            case complete = "TutorialComplete"
        }
        
        // MARK: - Properties

        public let publicKeyBase58Check: String
        public let profileEntryResponse: ProfileEntry?
        //Utxos               []*UTXOEntryResponse ?
        public let balanceNanos: UInt64
        public let unminedBalanceNanos: UInt64
        public let publicKeysBase58CheckFollowedByUser: [String]?
        public let usersYouHODL: [BalanceEntry]?
        public let usersWhoHODLYouCount: Int
        public let hasPhoneNumber: Bool
        public let canCreateProfile: Bool
        //public let BlockedPubKeys: [String: ]   map[string]struct{}
        public let hasEmail: Bool
        public let emailVerified: Bool
        public let jumioStartTime: UInt64
        public let jumioFinishedTime: UInt64
        public let jumioVerified: Bool
        public let jumioReturned: Bool
        public let isAdmin: Bool
        public let isSuperAdmin: Bool
        public let isBlacklisted: Bool
        public let isGraylisted: Bool
        public let tutorialStatus: TutorialStatus?
        public let creatorPurchasedInTutorialUsername: String?
        public let creatorCoinsPurchasedInTutorial: UInt64
        public let mustCompleteTutorial: Bool
        
        // MARK: - Protocol Conformance

        public var id: String {
            return self.publicKeyBase58Check
        }
        
        public var avatar: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-single-profile-picture")
                .appendingPathComponent(publicKeyBase58Check)
        }
        
    }
    
    struct ProfileEntry: DeSoAvatar, Codable, Identifiable {
        
        // MARK: - Properties
        
        public let publicKeyBase58Check: String
        public let username: String
        public let description: String
        public let isHidden: Bool
        public let isReserved: Bool
        public let isVerified: Bool
        public let comments: [PostEntry]?
        public let posts: [PostEntry]?
        public let coinEntry: CoinEntry?
        public let coinPriceDeSoNanos: UInt64
        public let usersThatHODL: [BalanceEntry]?
        public let isFeaturedTutorialWellKnownCreator: Bool
        public let isFeaturedTutorialUpAndComingCreator: Bool
        
        // MARK: - Protocol Conformance
        
        public var id: String {
            return self.publicKeyBase58Check
        }
        
        public var avatar: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-single-profile-picture")
                .appendingPathComponent(publicKeyBase58Check)
        }
        
        // MARK: - Helpers
        
        public var coinPrice: Double {
            return Double(coinPriceDeSoNanos) * 0.0000001
        }
        
        public func coinPriceFormatted(currencyCode: String = "usd") -> String {
            return coinPrice.formatted(.currency(code: currencyCode))
        }
        
        public var coinsInCirculation: Double {
            return coinEntry?.coinsInCirculation ?? .zero
        }
        
        public var usdLocked: Double {
            return coinEntry?.usdLocked ?? .zero
        }
        
        public func usdLockedFormatted() -> String {
            return usdLocked.formatted(.currency(code: "usd"))
        }
        
        public var usdMarketCap: Double {
            return coinPrice * coinsInCirculation
        }
        
        public func usdMarketCapFormatted() -> String {
            return usdMarketCap.formatted(.currency(code: "usd"))
        }
        
        public var createBasisPointsPercent: Double {
            return coinEntry?.creatorBasisPointsPercent ?? .zero
        }
        
        public var creatorBasesPercentFormatted: String {
            return coinEntry?.creatorBasesPercentFormatted ?? Double(0).formatted(.percent)
        }
        
    }
    
    struct BalanceEntry: Codable, Identifiable {
        public let hODLerPublicKeyBase58Check: String
        public let creatorPublicKeyBase58Check: String
        public let hasPurchased: Bool
        public let balanceNanos: UInt64
        public let netBalanceInMempool: UInt64
        public let profileEntryResponse: ProfileEntry?
        
        // MARK: - Protocol Conformance
        
        public var id: String {
            return self.hODLerPublicKeyBase58Check + self.creatorPublicKeyBase58Check
        }
        
        // MARK: - Helpers
        
        public var balance: Double {
            return Double(balanceNanos) * 0.000000001
        }
    }
    
    struct CoinEntry: Codable {
        public let creatorBasisPoints: UInt64
        public let deSoLockedNanos: UInt64
        public let numberOfHolders: UInt64
        public let coinsInCirculationNanos: UInt64
        public let coinWatermarkNanos: UInt64
        
        // MARK: - Helpers
        public var coinsInCirculation: Double {
            return Double(coinsInCirculationNanos) * 0.000000001
        }
        
        public var usdLocked: Double {
            return Double(deSoLockedNanos) * 0.0000001
        }
        
        public var creatorBasisPointsPercent: Double {
            return Double(creatorBasisPoints) * 0.0001
        }
        
        public var creatorBasesPercentFormatted: String {
            return creatorBasisPointsPercent.formatted(.percent)
        }
    }
}
