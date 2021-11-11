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
    
    public struct Transaction {}
    
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
