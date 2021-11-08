//
//  File.swift
//  
//
//  Created by Jacob Davis on 11/7/21.
//

import Foundation

public typealias ExchangeRateResponse = DeSoKit.Api.General.ExchangeRate.Response
public typealias AppStateResponse = DeSoKit.Api.General.AppState.Response

public extension DeSoKit.Api.General.ExchangeRate {
    
    struct Response: Codable {
        
        public let satoshisPerDeSoExchangeRate: UInt64
        public let nanosSold: UInt64
        
        let uSDCentsPerBitcoinExchangeRate: UInt64
        public var usdCentsPerBitcoinExchangeRate: UInt64 { // Vanity property :)
            return uSDCentsPerBitcoinExchangeRate
        }
        
    }
    
}

public extension DeSoKit.Api.General.AppState {
    
    struct Response: Codable {
        
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
