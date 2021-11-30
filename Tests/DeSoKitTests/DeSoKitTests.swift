import XCTest
@testable import DeSoKit

final class DeSoKitTests: XCTestCase {
    
    func testHealthCheck() async throws {
        do {
            let result: HealthCheckResponse = try await DeSoKit.Api.fetch(HealthCheckRequest())
            XCTAssertEqual(result, "200")
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testExchangeRate() async throws {
        do {
            let result: ExchangeRateResponse = try await DeSoKit.Api.fetch(ExchangeRateRequest())
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testAppState() async throws {
        do {
            let result: AppStateResponse = try await DeSoKit.Api.fetch(AppStateRequest())
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testUsersStatless() async throws {
        do {
            let request = UsersStatelessRequest(publicKeysBase58Check: ["BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu"], skipForLeaderboard: false)
            let result: UsersStatelessReponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testProfiles() async throws {
        do {
            let request = ProfilesRequest(readerPublicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result: ProfilesResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testSingleProfile() async throws {
        do {
            let request = SingleProfileRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result: ProfileResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testHODLers() async throws {
        do {
            let request = HODLersRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu", fetchHodlings: true, fetchAll: true)
            let result: HODLersResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testDiamonds() async throws {
        do {
            let request = DiamondsRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu", fetchYouDiamonded: false)
            let result: DiamondsResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testFollowsStateless() async throws {
        do {
            let request = FollowsStatelessRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result: FollowsStatelessResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testPostsStateless() async throws {
        do {
            let request = PostsStatelessRequest(postContent: "#010", numToFetch: 10000, getPostsForGlobalWhitelist: false)
            let result: PostsStatelessReponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testSinglePost() async throws {
        do {
            let request = SinglePostRequest(postHashHex: "6a2a883955a5a3842343460224a8b2b588335142600a1516180ae33e81e85d74")
            let result: SinglePostReponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testPostsForPublicKey() async throws {
        do {
            let request = PostsForPublicKeyRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result: PostsForPublicKeyResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testNotifications() async throws {
        do {
            let request = NotificationsRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result: NotificationsResponse = try await DeSoKit.Api.fetch(request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }

}
