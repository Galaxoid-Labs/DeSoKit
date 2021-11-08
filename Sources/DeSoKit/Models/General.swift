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
        
        public let SatoshisPerDeSoExchangeRate: UInt64
        public let NanosSold: UInt64
        public let USDCentsPerBitcoinExchangeRate: UInt64
        
    }
    
}

public extension DeSoKit.Api.General.AppState {
    
    struct Response: Codable {
        
        public let AmplitudeKey: String
        public let AmplitudeDomain: String
        public let MinSatoshisBurnedForProfileCreation: UInt64
        public let BlockHeight: UInt32
        public let IsTestnet: Bool
        public let SupportEmail: String
        public let ShowProcessingSpinners: Bool
        public let HasStarterDeSoSeed: Bool
        public let HasTwilioAPIKey: Bool
        public let CreateProfileFeeNanos: UInt64
        public let CompProfileCreation: Bool
        public let DiamondLevelMap: [String: UInt64]
        public let HasWyreIntegration: Bool
        public let HasJumioIntegration: Bool
        public let BuyWithETH: Bool
        public let USDCentsPerDeSoExchangeRate: UInt64
        public let JumioDeSoNanos: UInt64
        //public let TransactionFeeMap: [String: []] // TODO:
        public let BuyETHAddress: String
    }
    
}
