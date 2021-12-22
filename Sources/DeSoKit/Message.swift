//
//  Message.swift
//  
//
//  Created by Jacob Davis on 12/9/21.
//

import Foundation

public typealias MessagesStatelessRequest = DeSoKit.Message.MessagesStatelessRequest

public typealias MessagesStatelessResponse = DeSoKit.Message.MessagesStatelessResponse

public extension DeSoKit {
    struct Message {}
}

// MARK: - Requests
public extension DeSoKit.Message {
    
    
    struct MessagesStatelessRequest: DeSoPostRequest {
        
        public let publicKeyBase58Check: String
        public let fetchAfterPublicKeyBase58Check: String
        public let numToFetch: UInt64
        public let holdersOnly: Bool
        public let holdingsOnly: Bool
        public let followersOnly: Bool
        public let followingOnly: Bool
        public let sortAlgorithm: String
        
        // MARK: - Protocol Conformance

        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-messages-stateless")
        }
        
        public init(publicKeyBase58Check: String, fetchAfterPublicKeyBase58Check: String = "",
                    numToFetch: UInt64 = 20, holdersOnly: Bool = false, holdingsOnly: Bool = false,
                    followersOnly: Bool = false, followingOnly: Bool = false, sortAlgorithm: String = "") {
            self.publicKeyBase58Check = publicKeyBase58Check
            self.fetchAfterPublicKeyBase58Check = fetchAfterPublicKeyBase58Check
            self.numToFetch = numToFetch
            self.holdersOnly = holdersOnly
            self.holdingsOnly = holdingsOnly
            self.followersOnly = followersOnly
            self.followingOnly = followingOnly
            self.sortAlgorithm = sortAlgorithm
        }
    }
    
}

// MARK: - Responses
public extension DeSoKit.Message {
    
    struct MessagesStatelessResponse: Codable {
        public let publicKeyToProfileEntry: [String: ProfileEntry]
        public let orderedContactsWithMessages: [MessageContactResponse]
        public let unreadStateByContact: [String: Bool]
        public let numberOfUnreadThreads: Int
    }
    
    struct MessageContactResponse: Codable {
        public let publicKeyBase58Check: String
        public let messages: [MessageEntryResponse]
        public let profileEntryResponse: ProfileEntry?
        public let numMessagesRead: Int64
    }
    
    struct MessageEntryResponse: Codable {
        public let senderPublicKeyBase58Check: String
        public let recipientPublicKeyBase58Check: String
        public let encryptedText: String
        public let tstampNanos: UInt64
        public let isSender: Bool
        public let v2: Bool
    }
    
}
