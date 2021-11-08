//
//  Post.swift
//  
//
//  Created by Jacob Davis on 11/7/21.
//

import Foundation

public typealias PostEntry = DeSoKit.Api.Post.PostEntry

public extension DeSoKit.Api.Post {
    
    class PostEntry: Codable { // Only a class because some properties are of same type which is not allowed on struct
        
        public let PostHashHex: String
        public let PosterPublicKeyBase58Check: String
        public let ParentStakeID: String
        public let Body: String
        public let ImageURLs: [String]
        public let RecloutedPostEntryResponse: PostEntry
        public let CreatorBasisPoints: UInt64
        public let StakeMultipleBasisPoints: UInt64
        public let TimestampNanos: UInt64
        public let IsHidden: Bool
        public let ConfirmationBlockHeight: UInt32
        public let InMempool: Bool
//        StakeEntry                 *StakeEntryResponse
//        StakeEntryStats            *lib.StakeEntryStats
//        ProfileEntryResponse *ProfileEntryResponse
        public let Comments: [PostEntry]
        public let LikeCount: UInt64
        public let DiamondCount: UInt64
        //PostEntryReaderState *lib.PostEntryReaderState
        public let InGlobalFeed: Bool// *bool `json:",omitempty"`
        public let IsPinned: Bool// *bool `json:",omitempty"`
        public let PostExtraData: [String: String]// map[string]string
        public let CommentCount: UInt64
        public let RecloutCount: UInt64
        public let ParentPosts: [PostEntry]
        public let DiamondsFromSender: UInt64
        
    }
    
}
