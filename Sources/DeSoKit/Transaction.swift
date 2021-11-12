//
//  Transaction.swift
//  
//
//  Created by Jacob Davis on 11/12/21.
//

import Foundation

public typealias OutputResponse = DeSoKit.Transaction.OutputResponse
public typealias InputResponse = DeSoKit.Transaction.InputResponse
public typealias TransactionMetadataResponse = DeSoKit.Transaction.TransactionMetadataResponse
public typealias TransactionResponse = DeSoKit.Transaction.TransactionResponse


public extension DeSoKit {
    struct Transaction {}
}

// MARK: - Requests
public extension DeSoKit.Transaction {
    
//    struct NotificationsRequest: DeSoPostRequest {
//        public let publicKeyBase58Check: String
//        public init(publicKeyBase58Check: String) {
//            self.publicKeyBase58Check = publicKeyBase58Check
//        }
//        
//        // MARK: - Protocol Conformance
//        
//        public static var endpoint: URL {
//            return DeSoKit.baseURL
//                .appendingPathComponent(DeSoKit.basePath)
//                .appendingPathComponent("get-notifications")
//        }
//    }
    
}

// MARK: - Responses
public extension DeSoKit.Transaction {
    
//    struct NotificationsResponse: Codable {
//        //public let Notifications: [TransactionMetadataResponse]
//        public let profilesByPublicKey: [String: ProfileEntry]
//        public let postsByHash: [String: PostEntry]
//        public let lastSeenIndex: Int64
//    }
    
    struct OutputResponse: Codable {
        public let publicKeyBase58Check: String
        public let amountNanos: UInt64
    }
    
    struct InputResponse: Codable {
        public let transactionIDBase58Check: String
        public let index: UInt64
    }
    
    struct TransactionMetadataResponse: Codable {
        //public let metadata           *lib.TransactionMetadata
        public let txnOutputResponses: [OutputResponse]
        public let transactionResponse: TransactionResponse
        public let index: Int64
    }
    
    struct TransactionResponse: Codable {
        // A string that uniquely identifies this transaction. This is a sha256 hash
        // of the transaction’s data encoded using base58 check encoding.
        public let transactionIDBase58Check: String
        // The raw hex of the transaction data. This can be fully-constructed from
        // the human-readable portions of this object.
        public let rawTransactionHex: String?
        // The inputs and outputs for this transaction.
        public let inputs: [InputResponse]?
        public let outputs: [OutputResponse]?
        // The signature of the transaction in hex format.
        public let signatureHex: String?
        // Will always be “0” for basic transfers
        public let transactionType: String?
        // TODO: Create a TransactionMeta portion for the response.

        // The hash of the block in which this transaction was mined. If the
        // transaction is unconfirmed, this field will be empty. To look up
        // how many confirmations a transaction has, simply plug this value
        // into the "block" endpoint.
        public let blockHashHex: String?

        //public let transactionMetadata *lib.TransactionMetadata `json:",omitempty"`
    }
    
}

// MARK: - Models
public extension DeSoKit.Transaction {
    
}
