//
//  General.swift
//  
//
//  Created by Jacob Davis on 11/10/21.
//

import Foundation

public typealias AppStateRequest = DeSoKit.General.AppStateRequest
public typealias ExchangeRateRequest = DeSoKit.General.ExchangeRateRequest
public typealias HealthCheckRequest = DeSoKit.General.HealthCheckRequest
public typealias IndexRequest = DeSoKit.General.IndexRequest

public typealias IndexResponse = String
public typealias HealthCheckResponse = String
public typealias ExchangeRateResponse = DeSoKit.General.ExchangeRateResponse
public typealias AppStateResponse = DeSoKit.General.AppStateResponse

public extension DeSoKit {
    struct General {}
}

// MARK: - Requests
public extension DeSoKit.General {
    
    struct IndexRequest: DeSoGetRequest {
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
        }
    }
    
    struct HealthCheckRequest: DeSoGetRequest {
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("health-check")
        }
    }
    
    struct ExchangeRateRequest: DeSoGetRequest {
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-exchange-rate")
        }
    }
    
    struct AppStateRequest: DeSoPostRequest {
        public let publicKeyBase58Check: String
        public init(publicKeyBase58Check: String = "") {
            self.publicKeyBase58Check = publicKeyBase58Check
        }
        public static var endpoint: URL {
            return DeSoKit.baseURL
                .appendingPathComponent(DeSoKit.basePath)
                .appendingPathComponent("get-app-state")
        }
    }
    
}

// MARK: - Responses
public extension DeSoKit.General {
    
    struct ExchangeRateResponse: Codable {
        
        public let satoshisPerDeSoExchangeRate: UInt64
        
        let uSDCentsPerBitcoinExchangeRate: UInt64
        public var usdCentsPerBitcoinExchangeRate: UInt64 { // Vanity property :)
            return uSDCentsPerBitcoinExchangeRate
        }

        public let nanosPerETHExchangeRate: UInt64
        
        let uSDCentsPerETHExchangeRate: UInt64
        public var usdCentsPerETHExchangeRate: UInt64 { // Vanity property :)
            return uSDCentsPerETHExchangeRate
        }

        public let nanosSold: UInt64
        
        let uSDCentsPerDeSoExchangeRate: UInt64
        public var usdCentsPerDeSoExchangeRate: UInt64 { // Vanity property :)
            return uSDCentsPerDeSoExchangeRate
        }
        
        let uSDCentsPerDeSoReserveExchangeRate: UInt64
        public var usdCentsPerDeSoReserveExchangeRate: UInt64 { // Vanity property :)
            return uSDCentsPerDeSoReserveExchangeRate
        }
        
        public let buyDeSoFeeBasisPoints: UInt64
        
    }
    
    struct AppStateResponse: Codable {
        
        public let amplitudeKey: String
        public let amplitudeDomain: String
        public let minSatoshisBurnedForProfileCreation: UInt64
        public let blockHeight: UInt32
        public let isTestnet: Bool
        public let supportEmail: String
        public let showProcessingSpinners: Bool
        public let hasStarterDeSoSeed: Bool
        public let hasTwilioAPIKey: Bool
        public let createProfileFeeNanos: UInt64
        public let compProfileCreation: Bool
        public let diamondLevelMap: [String: UInt64]
        public let hasWyreIntegration: Bool
        public let hasJumioIntegration: Bool
        public let buyWithETH: Bool
        
        let uSDCentsPerDeSoExchangeRate: UInt64
        public var usdCentsPerDeSoExchangeRate: UInt64 {  // Vanity property :)
            return uSDCentsPerDeSoExchangeRate
        }
        
        public let jumioDeSoNanos: UInt64
        //public let TransactionFeeMap: [String: []] // TODO:
        public let buyETHAddress: String
    }
    
}