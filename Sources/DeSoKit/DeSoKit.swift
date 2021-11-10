import Foundation

public struct DeSoKit {
    
    public static let session = URLSession.shared
    public static var baseURL = URL(string: "https://bitclout.com")!
    public static var basePath = "api/v0"
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromPascalCase
        return decoder
    }
    
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToPascalCase
        return encoder
    }
    
    public struct Api {
        
        public struct General {
            
            public struct Index {
                public static func fetch() async throws -> String {
                    do {
                        let (data, res) = try await session.data(from: baseURL)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return String(decoding: data, as: UTF8.self)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct HealthCheck {
                public static func fetch() async throws -> String {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("health-check")

                        let (data, res) = try await session.data(from: endpoint)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return String(decoding: data, as: UTF8.self)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct ExchangeRate {
                public static func fetch() async throws -> ExchangeRateResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-exchange-rate")

                        let (data, res) = try await session.data(from: endpoint)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(ExchangeRateResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct AppStateRequest: Codable {
                public let publicKeyBase58Check: String
                public init(publicKeyBase58Check: String = "") {
                    self.publicKeyBase58Check = publicKeyBase58Check
                }
            }
            
            public struct AppState {
                public static func fetch(request: AppStateRequest = AppStateRequest()) async throws -> AppStateResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-app-state")

                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(AppStateResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
        }
        
        public struct Transaction {
            
            
        }
        
        public struct User {
            
            public struct UsersStatlessRequest: Codable {
                public let publicKeysBase58Check: [String]
                public let skipForLeaderboard: Bool
            }
            
            public struct UsersStatless {
                public static func fetch(request: UsersStatlessRequest) async throws -> UsersStatelessReponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-users-stateless")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(UsersStatelessReponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct ProfilesRequest: Codable {
                
                public enum OrderBy: String, Codable {
                    case none = ""
                    case influencerStake = "influencer_stake"
                    case influencerPostStake = "influencer_post_stake"
                    case newestLastPost = "newest_last_post"
                    case newestLastComment = "newest_last_comment"
                }
                
                public enum ModerationType: String, Codable {
                    case none = ""
                    case leaderboard = "leaderboard"
                }
                
                public let publicKeyBase58Check: String
                public let username: String
                public let usernamePrefix: String
                public let description: String
                public let orderBy: OrderBy
                public let numToFetch: UInt32
                public let readerPublicKeyBase58Check: String
                public let moderationType: ModerationType
                public let fetchUsersThatHODL: Bool
                public let addGlobalFeedBool: Bool
                
                public init(publicKeyBase58Check: String = "", username: String = "", usernamePrefix: String = "",
                            description: String = "", orderBy: OrderBy = .none, numToFetch: UInt32 = 20, readerPublicKeyBase58Check: String,
                            moderationType: ModerationType = .none, fetchUsersThatHODL: Bool = false, addGlobalFeedBool: Bool = false) {
                    self.publicKeyBase58Check = publicKeyBase58Check
                    self.username = username
                    self.usernamePrefix = usernamePrefix
                    self.description = description
                    self.orderBy = orderBy
                    self.numToFetch = numToFetch
                    self.readerPublicKeyBase58Check = readerPublicKeyBase58Check
                    self.moderationType = moderationType
                    self.fetchUsersThatHODL = fetchUsersThatHODL
                    self.addGlobalFeedBool = addGlobalFeedBool
                }
            }
            
            public struct Profiles {
                
                public static func fetch(request: ProfilesRequest) async throws -> ProfilesResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-profiles")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(ProfilesResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct ProfileRequest: Codable {

                public let publicKeyBase58Check: String?
                public let username: String?
                
                public init(publicKeyBase58Check: String? = "", username: String? = "") {
                    self.publicKeyBase58Check = publicKeyBase58Check
                    self.username = username
                }
                
            }
            
            public struct Profile {
                
                public static func fetch(request: ProfileRequest) async throws -> ProfileResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-single-profile")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(ProfileResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct HODLersRequest: Codable {

                public let publicKeyBase58Check: String
                public let username: String
                public let lastPublicKeyBase58Check: String
                public let numToFetch: UInt64
                public let fetchHodlings: Bool
                public let fetchAll: Bool
                
                public init(publicKeyBase58Check: String = "", username: String = "", lastPublicKeyBase58Check: String = "",
                            numToFetch: UInt64 = 20, fetchHodlings: Bool = false, fetchAll: Bool = false) {
                    self.publicKeyBase58Check = publicKeyBase58Check
                    self.username = username
                    self.lastPublicKeyBase58Check = lastPublicKeyBase58Check
                    self.numToFetch = numToFetch
                    self.fetchHodlings = fetchHodlings
                    self.fetchAll = fetchAll
                }
                
            }
            
            public struct HODLers {
                
                public static func fetch(request: HODLersRequest) async throws -> HODLersResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-hodlers-for-public-key")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(HODLersResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct DiamondsRequest: Codable {

                public let publicKeyBase58Check: String
                public let fetchYouDiamonded: Bool
                
                public init(publicKeyBase58Check: String, fetchYouDiamonded: Bool) {
                    self.publicKeyBase58Check = publicKeyBase58Check
                    self.fetchYouDiamonded = fetchYouDiamonded
                }
                
            }
            
            public struct Diamonds {
                
                public static func fetch(request: DiamondsRequest) async throws -> DiamondsResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-diamonds-for-public-key")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(DiamondsResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct FollowsStatelessRequest: Codable {
                public let publicKeyBase58Check: String
                public let username: String
                public let getEntriesFollowingUsername: Bool
                public let lastPublicKeyBase58Check: String
                public let numToFetch: UInt64
                
                public init(publicKeyBase58Check: String = "", username: String = "",
                            getEntriesFollowingUsername: Bool = false, lastPublicKeyBase58Check: String = "",
                            numToFetch: UInt64 = 20) {
                    self.publicKeyBase58Check = publicKeyBase58Check
                    self.username = username
                    self.getEntriesFollowingUsername = getEntriesFollowingUsername
                    self.lastPublicKeyBase58Check = lastPublicKeyBase58Check
                    self.numToFetch = numToFetch
                }
            }
            
            public struct FollowsStateless {
                
                public static func fetch(request: FollowsStatelessRequest) async throws -> FollowsStatelessResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-follows-stateless")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(FollowsStatelessResponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct UserGlobalMetadata { // TODO: Requires identity service
                
            }
            
            public struct UpdateUserGlobalMetadata { // TODO: Requires identity service
                
            }
            
            public struct Notifications { // TODO: Requires identity service
                
            }
            
            public struct Block { // TODO: Requires identity service
                
            }
            
        }
        
        public struct Post {
            
            public struct PostsStatelessRequest: Codable {
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
            
            public struct PostsStateless {
                public static func fetch(request: PostsStatelessRequest) async throws -> PostsStatelessReponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-posts-stateless")
                        
                        let req = try DeSoKit.GetPostRequest(withURL: endpoint, request: request)
                        let (data, res) = try await session.data(for: req)
                        
                        guard let response = res as? HTTPURLResponse else {
                            throw DeSoKitError.unknown
                        }
                        
                        if response.statusCode == 200 {
                            return try decoder.decode(PostsStatelessReponse.self, from: data)
                        } else if let errorResponse = try? decoder.decode(DeSoKitErrorResponse.self, from: data) {
                            throw DeSoKitError.error(message: errorResponse.error)
                        } else {
                            throw DeSoKitError.unknown
                        }
                        
                    } catch {
                        print("😭 DESOKIT ERROR: \(error.localizedDescription)")
                        throw error
                    }
                }
            }
            
            public struct Post {
                
            }
            
            public struct Posts {
                
            }
            
            public struct DiamondedPosts {
                
            }
        }
        
        public struct Balance {
            
            
        }
        
    }
    
    static func GetPostRequest<T: Encodable>(withURL url: URL, request: T) throws -> URLRequest {
        var req = URLRequest(url: url)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.httpMethod = "POST"
        do {
            req.httpBody = try encoder.encode(request)
            return req
        } catch {
            throw DeSoKitError.error(message: "Unable to encode Request")
        }
    }

    public enum DeSoKitError: LocalizedError {
        case error(message: String)
        case unknown
        public var errorDescription: String? {
            switch self {
            case let .error(message):
                return message
            case .unknown:
                return "An unknown error occured"
            }
        }
    }
    
    public struct DeSoKitErrorResponse: Codable {
        let error: String
    }

}

extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            guard let key = keys.last else {
                return AnyKey.empty
            }
            if key.intValue != nil {
                return key
            }
            let newKey = key.stringValue.prefix(1).lowercased() + key.stringValue.dropFirst()
            return AnyKey(string: newKey)
        }
    }
}

extension JSONEncoder.KeyEncodingStrategy {
    static var convertToPascalCase: JSONEncoder.KeyEncodingStrategy {
        return .custom { keys -> CodingKey in
            guard let key = keys.last else {
                return AnyKey.empty
            }
            if key.intValue != nil {
                return key
            }
            let newKey = key.stringValue.prefix(1).uppercased() + key.stringValue.dropFirst()
            return AnyKey(string: newKey)
        }
    }
}

struct AnyKey: CodingKey {
    
    static let empty = AnyKey(string: "")
    
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
    
    init(string: String) {
       self.stringValue = string
       self.intValue = nil
   }
}
