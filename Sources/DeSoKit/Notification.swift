//
//  File.swift
//  
//
//  Created by Jacob Davis on 11/12/21.
//

import Foundation

public typealias NotificationsRequest = DeSoKit.Notification.NotificationsRequest
public typealias NotificationsResponse = DeSoKit.Notification.NotificationsResponse

public extension DeSoKit {
    struct Notification {}
}

// MARK: - Requests
public extension DeSoKit.Notification {
    
    struct NotificationsRequest: DeSoPostRequest {
        public let publicKeyBase58Check: String
        public init(publicKeyBase58Check: String) {
            self.publicKeyBase58Check = publicKeyBase58Check
        }
        
        // MARK: - Protocol Conformance
        
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-notifications")
        }
    }
    
}

// MARK: - Responses
public extension DeSoKit.Notification {
    
    struct NotificationsResponse: Codable {
        public let notifications: [TransactionMetadataResponse]
        public let profilesByPublicKey: [String: ProfileEntry]
        public let postsByHash: [String: PostEntry]
        public let lastSeenIndex: Int64
    }
    
}

// MARK: - Models
public extension DeSoKit.Notification {
    
}
