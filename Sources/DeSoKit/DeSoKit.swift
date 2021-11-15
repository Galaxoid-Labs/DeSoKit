import Foundation
import DeSoIdentity

public struct DeSoKit {
    
    public static let session = URLSession.shared
    public static var baseURL = URL(string: "https://node.deso.org")!
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
        
        public static func fetch<T: DeSoGetRequest, R: Decodable>(_ request: T) async throws -> R {
            do {
                let (data, res) = try await session.data(from: T.endpoint)
                
                guard let response = res as? HTTPURLResponse else {
                    throw DeSoKitError.unknown
                }
                
                if response.statusCode == 200 {
                    if R.self is String.Type {
                        guard let responseObject = String(decoding: data, as: UTF8.self) as? R else {
                            throw DeSoKitError.error(message: "Unable to decode Response")
                        }
                        return responseObject
                    } else {
                        return try decoder.decode(R.self, from: data)
                    }
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
        
        public static func fetch<T: DeSoPostRequest, R: Decodable>(_ request: T) async throws -> R {
            do {
                
                let req = try DeSoKit.buildPostRequest(withURL: T.endpoint, request: request)
                let (data, res) = try await session.data(for: req)
                
                guard let response = res as? HTTPURLResponse else {
                    throw DeSoKitError.unknown
                }
                
                if response.statusCode == 200 {
                    print(String(data: try! JSONSerialization.data(withJSONObject: try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed), options: .prettyPrinted), encoding: .utf8 )!)

                    return try decoder.decode(R.self, from: data)
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
    
    #if os(iOS)
    public struct Identity {
        
        public func login() async throws -> (selectedPublicKeyBase58Check: String, allLoadedPublicKeyBase58Checks: [String]) {
            
            return try await withCheckedThrowingContinuation({
                (continuation: CheckedContinuation<(selectedPublicKeyBase58Check: String, allLoadedPublicKeyBase58Checks: [String]), Error>) in
                do {
                    let identity = try DeSoIdentity.Identity()
                    identity.login { response in
                        switch response {
                        case .success(let selectedPublicKey, let allLoadedPublicKeys):
                            continuation.resume(returning: (selectedPublicKeyBase58Check: selectedPublicKey, allLoadedPublicKeyBase58Checks: allLoadedPublicKeys))
                        case .failed(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                } catch {
                    continuation.resume(throwing: error)
                }
            })
            
        }
        
        public func logout(_ publicKeyBase58Check: String) throws -> [String] {
            do {
                let identity = try DeSoIdentity.Identity()
                return try identity.logout(publicKeyBase58Check)
            } catch {
                throw error
            }
        }
        
        public func getLoggedInKeys() throws -> [String] {
            do {
                let identity = try DeSoIdentity.Identity()
                return try identity.getLoggedInKeys()
            } catch {
                throw error
            }
        }
        
        public func removeAllKeys() throws {
            do {
                let identity = try DeSoIdentity.Identity()
                try identity.removeAllKeys()
            } catch {
                throw error
            }
        }
        
    }
    #endif
    
    static func buildPostRequest<T: Encodable>(withURL url: URL, request: T) throws -> URLRequest {
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

public protocol DeSoPostRequest: Codable {
    static var endpoint: URL { get }
}

public protocol DeSoGetRequest {
    static var endpoint: URL { get }
}

public protocol DeSoAvatar {
    var avatar: URL { get }
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
