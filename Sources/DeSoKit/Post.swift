//
//  Post.swift
//  
//
//  Created by Jacob Davis on 11/7/21.
//

import Foundation

public typealias PostsStatelessRequest = DeSoKit.Post.PostsStatelessRequest
public typealias SinglePostRequest = DeSoKit.Post.SinglePostRequest

public typealias PostsStatelessReponse = DeSoKit.Post.PostsStatelessResponse
public typealias SinglePostReponse = DeSoKit.Post.SinglePostResponse

public typealias PostEntry = DeSoKit.Post.PostEntry

public extension DeSoKit {
    struct Post {}
}

// MARK: - Requests
public extension DeSoKit.Post {
    
    struct PostsStatelessRequest: DeSoPostRequest {
        public let postHashHex: String
        public let readerPublicKeyBase58Check: String
        public let orderBy: String
        public let startTstampSecs: UInt64?
        public let postContent: String
        public let numToFetch: Int
        public let fetchSubcomments: Bool
        public let getPostsForFollowFeed: Bool
        public let getPostsForGlobalWhitelist: Bool
        public let getPostsByDESO: Bool
        public let mediaRequired: Bool
        public let postsByDESOMinutesLookback: UInt64
        public let addGlobalFeedBool: Bool
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-posts-stateless")
        }
        
        public init(postHashHex: String = "", readerPublicKeyBase58Check: String = "", orderBy: String = "",
                    startTstampSecs: UInt64? = nil, postContent: String = "", numToFetch: Int = 50, fetchSubcomments: Bool = false,
                    getPostsForFollowFeed: Bool = false, getPostsForGlobalWhitelist: Bool = true, getPostsByDESO: Bool = false,
                    mediaRequired: Bool = false, postsByDESOMinutesLookback: UInt64 = 0, addGlobalFeedBool: Bool = false) {
            self.postHashHex = postHashHex
            self.readerPublicKeyBase58Check = readerPublicKeyBase58Check
            self.orderBy = orderBy
            self.startTstampSecs = startTstampSecs
            self.postContent = postContent
            self.numToFetch = numToFetch
            self.fetchSubcomments = fetchSubcomments
            self.getPostsForFollowFeed = getPostsForFollowFeed
            self.getPostsForGlobalWhitelist = getPostsForGlobalWhitelist
            self.getPostsByDESO = getPostsByDESO
            self.mediaRequired = mediaRequired
            self.postsByDESOMinutesLookback = postsByDESOMinutesLookback
            self.addGlobalFeedBool = addGlobalFeedBool
        }
        
    }
    
    struct SinglePostRequest: DeSoPostRequest {
        public let postHashHex: String
        public let fetchParents: Bool
        public let commentOffset: UInt32
        public let commentLimit: UInt32
        public let readerPublicKeyBase58Check: String
        public let addGlobalFeedBool: Bool
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-single-post")
        }
        
        public init(postHashHex: String, fetchParents: Bool = false, commentOffset: UInt32 = 0, commentLimit: UInt32 = 0, readerPublicKeyBase58Check: String = "", addGlobalFeedBool: Bool = false) {
            self.postHashHex = postHashHex
            self.fetchParents = fetchParents
            self.commentOffset = commentOffset
            self.commentLimit = commentLimit
            self.readerPublicKeyBase58Check = readerPublicKeyBase58Check
            self.addGlobalFeedBool = addGlobalFeedBool
        }
    }
    
}

// MARK: - Responses
public extension DeSoKit.Post {
    
    struct PostsStatelessResponse: Codable {
        public let postsFound: [PostEntry]
    }
    
    struct SinglePostResponse: Codable {
        public let postFound: PostEntry
    }
    
}

// MARK: - Models
public extension DeSoKit.Post {
    
    class PostEntry: DeSoAvatar, Codable, Identifiable { // Only a class because some properties are of same type which is not allowed on struct: TODO:
        
        public var id: String {
            return self.postHashHex
        }
        
        public var avatar: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-single-profile-picture")
                .appendingPathComponent(posterPublicKeyBase58Check)
        }
        
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
