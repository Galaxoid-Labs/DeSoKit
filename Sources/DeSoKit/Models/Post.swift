//
//  Post.swift
//  
//
//  Created by Jacob Davis on 11/7/21.
//

import Foundation

public typealias PostEntry = DeSoKit.Api.Post.PostEntry
public typealias PostsStatelessReponse = DeSoKit.Api.Post.PostsStateless.Response

public extension DeSoKit.Api.Post {
    
    class PostEntry: Codable { // Only a class because some properties are of same type which is not allowed on struct: TODO:
        public let postHashHex: String
        public let posterPublicKeyBase58Check: String
        public let parentStakeID: String
        public let body: String
        public let imageURLs: [String]?
        public let videoURLs: [String]?
        public let repostedPostEntryResponse: PostEntry?
        public let creatorBasisPoints: UInt64
        public let stakeMultipleBasisPoints: UInt64
        public let timestampNanos: UInt64
        public let isHidden: Bool
        public let confirmationBlockHeight: UInt32
        public let inMempool: Bool
        public let profileEntryResponse: ProfileEntry
        public let comments: [PostEntry]?
        public let likeCount: UInt64
        public let diamondCount: UInt64
        public let postEntryReaderState: PostEntryReaderState?
        public let inGlobalFeed: Bool?
        public let inHotFeed: Bool?
        public let isPinned: Bool?
        public let postExtraData: [String: String]
        public let commentCount: UInt64
        public let repostCount: UInt64
        public let quoteRepostCount: UInt64
        public let parentPosts: [PostEntry]?
        public let isNFT: Bool
        public let numNFTCopies: UInt64
        public let numNFTCopiesForSale: UInt64
        public let numNFTCopiesBurned: UInt64
        public let hasUnlockable: Bool
        public let nFTRoyaltyToCreatorBasisPoints: UInt64
        public let nFTRoyaltyToCoinBasisPoints: UInt64
        public let diamondsFromSender: UInt64
        public let hotnessScore: UInt64
        public let postMultiplier: Float64
        
    }
    
    struct PostEntryReaderState: Codable {
        public let diamondLevelBestowed: UInt64
        public let likedByReader: Bool
        public let repostPostHashHex: String
        public let repostedByReader: Bool
    }
    
}

public extension DeSoKit.Api.Post.PostsStateless {
    
    struct Response: Codable {
        public let postsFound: [PostEntry]
    }
    
}
