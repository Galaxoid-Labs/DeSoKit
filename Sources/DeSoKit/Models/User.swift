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
            case EMPTY = ""
            case STARTED = "TutorialStarted"
            case SKIPPED = "TutorialSkipped"
            case INVEST_OTHERS_BUY = "InvestInOthersBuyComplete"
            case INVEST_OTHERS_SELL = "InvestInOthersSellComplete"
            case CREATE_PROFILE = "TutorialCreateProfileComplete"
            case INVEST_SELF = "InvestInYourselfComplete"
            case FOLLOW_CREATORS = "FollowCreatorsComplete"
            case DIAMOND = "GiveADiamondComplete"
            case COMPLETE = "TutorialComplete"
        }
        
        public let PublicKeyBase58Check: String
        public let ProfileEntryResponse: ProfileEntry
        //Utxos               []*UTXOEntryResponse ?
        public let BalanceNanos: UInt64
        public let UnminedBalanceNanos: UInt64
        public let PublicKeysBase58CheckFollowedByUser: [String]
        public let UsersYouHODL: [BalanceEntry]
        public let UsersWhoHODLYouCount: Int
        public let HasPhoneNumber: Bool
        public let CanCreateProfile: Bool
        //public let BlockedPubKeys: [String: ]   map[string]struct{}
        public let HasEmail: Bool
        public let EmailVerified: Bool
        public let JumioStartTime: UInt64
        public let JumioFinishedTime: UInt64
        public let JumioVerified: Bool
        public let JumioReturned: Bool
        public let IsAdmin: Bool
        public let IsSuperAdmin: Bool
        public let IsBlacklisted: Bool
        public let IsGraylisted: Bool
        public let TutorialStatus: TutorialStatus?
        public let CreatorPurchasedInTutorialUsername: String?
        public let CreatorCoinsPurchasedInTutorial: UInt64
        public let MustCompleteTutorial: Bool
        
    }
    
    struct ProfileEntry: Codable {
        
        public let PublicKeyBase58Check: String
        public let Username: String
        public let Description: String
        public let IsHidden: Bool
        public let IsReserved: Bool
        public let IsVerified: Bool
        public let Comments: [PostEntry]?
        public let Posts: [PostEntry]?
        //public let CoinEntry lib.CoinEntry TODO:
        public let CoinPriceDeSoNanos: UInt64
        public let UsersThatHODL: [BalanceEntry]?
        public let IsFeaturedTutorialWellKnownCreator: Bool
        public let IsFeaturedTutorialUpAndComingCreator: Bool
        
    }
    
    struct BalanceEntry: Codable {
        
        public let HODLerPublicKeyBase58Check: String
        public let CreatorPublicKeyBase58Check: String
        public let HasPurchased: Bool
        public let BalanceNanos: UInt64
        public let NetBalanceInMempool: UInt64
        public let ProfileEntryResponse: ProfileEntry
        
    }
    
}

public extension DeSoKit.Api.User.UsersStatless {
    
    struct Response: Codable {
        
        public let UserList: [User]
        public let DefaultFeeRateNanosPerKB: UInt64
        public let ParamUpdaters: [String: Bool]
        
    }
    
}

public extension DeSoKit.Api.User.Profiles {
    
    struct Response: Codable {
        
        public let ProfilesFound: [ProfileEntry]
        public let NextPublicKey: String?
        
    }
    
}

public extension DeSoKit.Api.User.Profile {
    
    struct Response: Codable {
        public let Profile: ProfileEntry
    }
    
}

public extension DeSoKit.Api.User.HODLers {
    
    struct Response: Codable {
        
        public let Hodlers: [BalanceEntry]
        public let LastPublicKeyBase58Check: String
        
    }
    
}

public extension DeSoKit.Api.User.Diamonds {
    
    struct DiamondsSenderSummary: Codable {
        public let SenderPublicKeyBase58Check: String
        public let ReceiverPublicKeyBase58Check: String
        public let TotalDiamonds: UInt64
        public let HighestDiamondLevel: UInt64
        public let DiamondLevelMap: [String: UInt64]
        public let ProfileEntryResponse: ProfileEntry
    }
    
    struct Response: Codable {
        
        public let DiamondSenderSummaryResponses: [DiamondsSenderSummary]
        public let TotalDiamonds: UInt64
        
    }

}

public extension DeSoKit.Api.User.FollowsStateless {
    
    struct Response: Codable {
        
        public let PublicKeyToProfileEntry: [String: ProfileEntry]
        public let NumFollowers: UInt64
        
    }
    
}
