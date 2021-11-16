//
//  Transaction.swift
//  
//
//  Created by Jacob Davis on 11/12/21.
//

import Foundation
import DeSoIdentity

public typealias CreateLikeStatelessRequest = DeSoKit.Transaction.CreateLikeStatelessRequest
public typealias SubmitTransactionRequest = DeSoKit.Transaction.SubmitTransactionRequest

public typealias CreateLikeStatelessResponse = DeSoKit.Transaction.CreateLikeStatelessResponse
public typealias SubmitTransactionResponse = DeSoKit.Transaction.SubmitTransactionResponse
public typealias OutputResponse = DeSoKit.Transaction.OutputResponse
public typealias InputResponse = DeSoKit.Transaction.InputResponse
public typealias TransactionMetadataResponse = DeSoKit.Transaction.TransactionMetadataResponse
public typealias TransactionResponse = DeSoKit.Transaction.TransactionResponse

public typealias UnsignedTransaction = DeSoIdentity.UnsignedTransaction

public extension DeSoKit {
    struct Transaction {}
}

// MARK: - Requests
public extension DeSoKit.Transaction {
    
    
    struct CreateLikeStatelessRequest: DeSoPostRequest {

        
        public let readerPublicKeyBase58Check: String
        public let likedPostHashHex: String
        public let isUnlike: Bool
        public let minFeeRateNanosPerKB: UInt64
        //TransactionFees []TransactionFee `safeForLogging:"true"`
        
        // MARK: - Protocol Conformance

        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("create-like-stateless")
        }
        
        public init(readerPublicKeyBase58Check: String, likedPostHashHex: String,
                    isUnlike: Bool = false, minFeeRateNanosPerKB: UInt64 = 1000) {
            self.readerPublicKeyBase58Check = readerPublicKeyBase58Check
            self.likedPostHashHex = likedPostHashHex
            self.isUnlike = isUnlike
            self.minFeeRateNanosPerKB = minFeeRateNanosPerKB
        }

    }
    
    struct SubmitTransactionRequest: DeSoPostRequest {

        public let transactionHex: String
        
        // MARK: - Protocol Conformance

        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("submit-transaction")
        }
        
        public init(transactionHex: String) {
            self.transactionHex = transactionHex
        }
    }
    
}

// MARK: - Responses
public extension DeSoKit.Transaction {
    
    struct CreateLikeStatelessResponse: Codable {
        public let totalInputNanos: UInt64
        public let changeAmountNanos: UInt64
        public let feeNanos: UInt64
        //public let Transaction       *lib.MsgDeSoTxn // TODO:
        public let transactionHex: String
    }
    
    struct SubmitTransactionResponse: Codable {
        //Transaction *lib.MsgDeSoTxn // TODO:
        public let txnHashHex: String
        public let postEntryResponse: PostEntry?
    }
    
    struct OutputResponse: Codable {
        public let publicKeyBase58Check: String
        public let amountNanos: UInt64
    }
    
    struct InputResponse: Codable {
        public let transactionIDBase58Check: String
        public let index: UInt64
    }
    
    struct TransactionMetadataResponse: Codable {
        //public let metadata           *lib.TransactionMetadata // TODO:
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

        //public let transactionMetadata *lib.TransactionMetadata `json:",omitempty"`  // TODO:
    }
    
}

// MARK: - Models
public extension DeSoKit.Transaction {
    
}
