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
        
        public let postHashHex: String
        public let posterPublicKeyBase58Check: String
        public let parentStakeID: String
        public let body: String
        public let imageURLs: [String]
        public let recloutedPostEntryResponse: PostEntry
        public let creatorBasisPoints: UInt64
        public let stakeMultipleBasisPoints: UInt64
        public let timestampNanos: UInt64
        public let isHidden: Bool
        public let confirmationBlockHeight: UInt32
        public let inMempool: Bool
//        StakeEntry                 *StakeEntryResponse
//        StakeEntryStats            *lib.StakeEntryStats
//        ProfileEntryResponse *ProfileEntryResponse
        public let comments: [PostEntry]
        public let likeCount: UInt64
        public let diamondCount: UInt64
        //PostEntryReaderState *lib.PostEntryReaderState
        public let inGlobalFeed: Bool// *bool `json:",omitempty"`
        public let isPinned: Bool// *bool `json:",omitempty"`
        public let postExtraData: [String: String]// map[string]string
        public let commentCount: UInt64
        public let recloutCount: UInt64
        public let parentPosts: [PostEntry]
        public let diamondsFromSender: UInt64
        
    }
    
}
