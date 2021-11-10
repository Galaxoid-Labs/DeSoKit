import XCTest
@testable import DeSoKit

final class DeSoKitTests: XCTestCase {
    
    // Using bitclout.com not sure how to get index as it returns html, etc...
//    func testIndex() async throws {
//        let result = try await Deso.General.Index.get()
//        XCTAssertEqual(result, "Your BitClout node is running!\n")
//    }
    
    func testHealthCheck() async throws {
        do {
            let result = try await DeSoKit.Api.General.HealthCheck.fetch()
            XCTAssertEqual(result, "200")
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testExchangeRate() async throws {
        do {
            let result = try await DeSoKit.Api.General.ExchangeRate.fetch()
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testAppState() async throws {
        do {
            let result = try await DeSoKit.Api.General.AppState.fetch()
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testUsersStatless() async throws {
        do {
            let request = DeSoKit.Api.User.UsersStatlessRequest(publicKeysBase58Check: ["BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu"], skipForLeaderboard: false)
            let result = try await DeSoKit.Api.User.UsersStatless
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testProfiles() async throws {
        do {
            let request = DeSoKit.Api.User.ProfilesRequest(readerPublicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result = try await DeSoKit.Api.User.Profiles
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testProfile() async throws {
        do {
            let request = DeSoKit.Api.User.ProfileRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result = try await DeSoKit.Api.User.Profile
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testHODLers() async throws {
        do {
            let request = DeSoKit.Api.User.HODLersRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result = try await DeSoKit.Api.User.HODLers
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testDiamonds() async throws {
        do {
            let request = DeSoKit.Api.User.DiamondsRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu", fetchYouDiamonded: false)
            let result = try await DeSoKit.Api.User.Diamonds
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testFollowsStateless() async throws {
        do {
            let request = DeSoKit.Api.User.FollowsStatelessRequest(publicKeyBase58Check: "BC1YLg7h8v4kQD1Cw3utW2U5RY2FQiLapc6BLjiWx98LyXSJC7yZcZu")
            let result = try await DeSoKit.Api.User.FollowsStateless
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testPostsStateless() async throws {
        do {
            let request = DeSoKit.Api.Post.PostsStatelessRequest()
            let result = try await DeSoKit.Api.Post.PostsStateless
                .fetch(request: request)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("\(error)")
        }
    }
}
