//
//  User.swift
//  
//
//  Created by Jacob Davis on 11/7/21.
//

import Foundation

public typealias User = DeSoKit.Api.User.User
public typealias ProfileEntry = DeSoKit.Api.User.ProfileEntry
public typealias BalanceEntry = DeSoKit.Api.User.BalanceEntry
public typealias UsersStatelessReponse = DeSoKit.Api.User.UsersStatless.Response
public typealias ProfilesResponse = DeSoKit.Api.User.Profiles.Response
public typealias ProfileResponse = DeSoKit.Api.User.Profile.Response
public typealias HODLersResponse = DeSoKit.Api.User.HODLers.Response
public typealias DiamondsResponse = DeSoKit.Api.User.Diamonds.Response
public typealias FollowsStatelessResponse = DeSoKit.Api.User.FollowsStateless.Response

public extension DeSoKit.Api.User {
    
    struct User: Codable {
        
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
        
        public let publicKeyBase58Check: String
        public let profileEntryResponse: ProfileEntry
        //Utxos               []*UTXOEntryResponse ?
        public let balanceNanos: UInt64
        public let unminedBalanceNanos: UInt64
        public let publicKeysBase58CheckFollowedByUser: [String]
        public let usersYouHODL: [BalanceEntry]
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
        
    }
    
    struct ProfileEntry: Codable {
        
        public let publicKeyBase58Check: String
        public let username: String
        public let description: String
        public let isHidden: Bool
        public let isReserved: Bool
        public let isVerified: Bool
        public let comments: [PostEntry]?
        public let posts: [PostEntry]?
        //public let CoinEntry lib.CoinEntry TODO:
        public let coinPriceDeSoNanos: UInt64
        public let usersThatHODL: [BalanceEntry]?
        public let isFeaturedTutorialWellKnownCreator: Bool
        public let isFeaturedTutorialUpAndComingCreator: Bool
        
    }
    
    struct BalanceEntry: Codable {
        public let hODLerPublicKeyBase58Check: String
        public let creatorPublicKeyBase58Check: String
        public let hasPurchased: Bool
        public let balanceNanos: UInt64
        public let netBalanceInMempool: UInt64
        public let profileEntryResponse: ProfileEntry
    }
    
}

public extension DeSoKit.Api.User.UsersStatless {
    
    struct Response: Codable {
        public let userList: [User]
        public let defaultFeeRateNanosPerKB: UInt64
        public let paramUpdaters: [String: Bool]
    }
    
}

public extension DeSoKit.Api.User.Profiles {
    
    struct Response: Codable {
        public let profilesFound: [ProfileEntry]
        public let nextPublicKey: String?
    }
    
}

public extension DeSoKit.Api.User.Profile {
    
    struct Response: Codable {
        public let profile: ProfileEntry
    }
    
}

public extension DeSoKit.Api.User.HODLers {
    
    struct Response: Codable {
        public let hodlers: [BalanceEntry]
        public let lastPublicKeyBase58Check: String
    }
    
}

public extension DeSoKit.Api.User.Diamonds {
    
    struct DiamondsSenderSummary: Codable {
        public let senderPublicKeyBase58Check: String
        public let receiverPublicKeyBase58Check: String
        public let totalDiamonds: UInt64
        public let highestDiamondLevel: UInt64
        public let diamondLevelMap: [String: UInt64]
        public let profileEntryResponse: ProfileEntry
    }
    
    struct Response: Codable {
        public let diamondSenderSummaryResponses: [DiamondsSenderSummary]
        public let totalDiamonds: UInt64
    }

}

public extension DeSoKit.Api.User.FollowsStateless {
    
    struct Response: Codable {
        public let publicKeyToProfileEntry: [String: ProfileEntry]
        public let numFollowers: UInt64
    }
    
}
