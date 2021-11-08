import Foundation
import AppKit

public struct DeSoKit {
    
    public static let session = URLSession.shared
    public static var baseURL = URL(string: "https://bitclout.com")!
    public static var basePath = "api/v0"
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    static var encoder: JSONEncoder {
        let decoder = JSONEncoder()
        return decoder
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
            
            public struct AppState {
                public static func fetch() async throws -> AppStateResponse {
                    do {
                        let endpoint = baseURL
                            .appendingPathComponent(basePath)
                            .appendingPathComponent("get-app-state")
                        var req = URLRequest(url: endpoint)
                        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        req.addValue("application/json", forHTTPHeaderField: "Accept")
                        req.httpMethod = "POST"
                        req.httpBody = try JSONSerialization.data(withJSONObject: [:], options: .prettyPrinted)

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
                public let PublicKeysBase58Check: [String]
                public let SkipForLeaderboard: Bool
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
                    case None = ""
                    case InfluencerStake = "influencer_stake"
                    case InfluencerPostStake = "influencer_post_stake"
                    case NewestLastPost = "newest_last_post"
                    case NewestLastComment = "newest_last_comment"
                }
                
                public enum ModerationType: String, Codable {
                    case None = ""
                    case Leaderboard = "leaderboard"
                }
                
                public let PublicKeyBase58Check: String
                public let Username: String
                public let UsernamePrefix: String
                public let Description: String
                public let OrderBy: OrderBy
                public let NumToFetch: UInt32
                public let ReaderPublicKeyBase58Check: String
                public let ModerationType: ModerationType
                public let FetchUsersThatHODL: Bool
                public let AddGlobalFeedBool: Bool
                
                public init(PublicKeyBase58Check: String = "", Username: String = "", UsernamePrefix: String = "",
                            Description: String = "", OrderBy: OrderBy = .None, NumToFetch: UInt32 = 20, ReaderPublicKeyBase58Check: String,
                            ModerationType: ModerationType = .None, FetchUsersThatHODL: Bool = false, AddGlobalFeedBool: Bool = false) {
                    self.PublicKeyBase58Check = PublicKeyBase58Check
                    self.Username = Username
                    self.UsernamePrefix = UsernamePrefix
                    self.Description = Description
                    self.OrderBy = OrderBy
                    self.NumToFetch = NumToFetch
                    self.ReaderPublicKeyBase58Check = ReaderPublicKeyBase58Check
                    self.ModerationType = ModerationType
                    self.FetchUsersThatHODL = FetchUsersThatHODL
                    self.AddGlobalFeedBool = AddGlobalFeedBool
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

                public let PublicKeyBase58Check: String?
                public let Username: String?
                
                public init(PublicKeyBase58Check: String? = "", Username: String? = "") {
                    self.PublicKeyBase58Check = PublicKeyBase58Check
                    self.Username = Username
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

                public let PublicKeyBase58Check: String
                public let Username: String
                public let LastPublicKeyBase58Check: String
                public let NumToFetch: UInt64
                public let FetchHodlings: Bool
                public let FetchAll: Bool
                
                public init(PublicKeyBase58Check: String = "", Username: String = "", LastPublicKeyBase58Check: String = "",
                            NumToFetch: UInt64 = 20, FetchHodlings: Bool = false, FetchAll: Bool = false) {
                    self.PublicKeyBase58Check = PublicKeyBase58Check
                    self.Username = Username
                    self.LastPublicKeyBase58Check = LastPublicKeyBase58Check
                    self.NumToFetch = NumToFetch
                    self.FetchHodlings = FetchHodlings
                    self.FetchAll = FetchAll
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

                public let PublicKeyBase58Check: String
                public let FetchYouDiamonded: Bool
                
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
                // Either PublicKeyBase58Check or Username can be set by the client to specify
                // which user we're obtaining follows for
                // If both are specified, PublicKeyBase58Check will supercede
                public let PublicKeyBase58Check: String
                public let Username: String
                public let GetEntriesFollowingUsername: Bool
                // Public Key of the last follower / followee from the previous page
                public let LastPublicKeyBase58Check: String
                // Number of records to fetch
                public let NumToFetch: UInt64
                
                public init(PublicKeyBase58Check: String = "", Username: String = "",
                            GetEntriesFollowingUsername: Bool = false, LastPublicKeyBase58Check: String = "",
                            NumToFetch: UInt64 = 20) {
                    self.PublicKeyBase58Check = PublicKeyBase58Check
                    self.Username = Username
                    self.GetEntriesFollowingUsername = GetEntriesFollowingUsername
                    self.LastPublicKeyBase58Check = LastPublicKeyBase58Check
                    self.NumToFetch = NumToFetch
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
            
            public class PostsStatelessRequest: Codable {
//                // This is the PostHashHex of the post we want to start our paginated lookup at. We
//                // will fetch up to "NumToFetch" posts after it, ordered by time stamp.  If no
//                // PostHashHex is provided we will return the most recent posts.
//                public let PostHashHex: String
//                public let ReaderPublicKeyBase58Check: String
//                public let OrderBy: String
//                public let StartTstampSecs: UInt64
//                public let PostContent: String
//                public let NumToFetch: Int
//
//                // Note: if the GetPostsForFollowFeed option is passed, FetchSubcomments is currently ignored
//                // (fetching comments / subcomments for the follow feed is currently unimplemented)
//                public let FetchSubcomments: Bool
//
//                // This gets posts by people that ReaderPublicKeyBase58Check follows.
//                public let GetPostsForFollowFeed: Bool
//
//                // This gets posts by people that ReaderPublicKeyBase58Check follows.
//                public let GetPostsForGlobalWhitelist: Bool
//
//                // This gets posts sorted by deso
//                public let GetPostsByDESO: Bool
//
//                // This only gets posts that include media, like photos and videos
//                public let MediaRequired: Bool
//
//                public let PostsByDESOMinutesLookback: UInt64
//
//                // If set to true, then the posts in the response will contain a boolean about whether they're in the global feed
//                public let AddGlobalFeedBool: Bool
            }
            
            
            public struct PostsStateless {
                
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
    
    static func GetPostRequest<T: Codable>(withURL url: URL, request: T) throws -> URLRequest {
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
