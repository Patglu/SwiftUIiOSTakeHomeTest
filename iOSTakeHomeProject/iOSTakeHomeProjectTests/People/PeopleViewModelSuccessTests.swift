import XCTest
@testable import iOSTakeHomeProject

final class PeopleViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerimplementation!
    private var viewModel: PeopleViewModel!
    
    override func setUpWithError() throws {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        viewModel = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDownWithError() throws {
        networkingMock = nil
        viewModel = nil
    }

    func test_WithSuccessfulResponseUsersArrayIsSet() async {
        // Checking if is loading is reset
        XCTAssertFalse(viewModel.isLoading, "The viewModel shouldn't be loading any data")
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(viewModel.viewState, .finished, "The view model state should be finished")
        }
        await viewModel.fetchUsers()
        XCTAssertFalse(viewModel.isLoading, "The viewModel shouldn't be loading any data")
        XCTAssertEqual(viewModel.users.count, 6, "There should be 6  sueres withing our data array")
    }
    
    func test_withSuccessfulPaginatedResponseUsersArrayIsSet() async throws {
        
        XCTAssertFalse(viewModel.isLoading, "The viewModel shouldn't be loading any data")
        
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(viewModel.viewState, .finished, "The view model state should be finished")
        }
        
        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.users.count, 6, "There should be 6  sueres withing our data array")
        
        await viewModel.fetchNextSetOfUsers()
        XCTAssertEqual(viewModel.users.count, 12, "There should be 12 users within our data")
        XCTAssertEqual(viewModel.page , 2, "Ther page should be 2 ")
    }
    
    func test_withResetCalledValuesIsReset() async throws {
        
        defer {
            XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users within our data array")
            XCTAssertEqual(viewModel.page ,1, "Ther page should be 2 ")
            XCTAssertEqual(viewModel.totalPages ,2, "Ther page should be 2 ")
            XCTAssertEqual(viewModel.viewState, .finished)
            XCTAssertFalse(viewModel.isLoading, "The view model shoudn't be loading any data ")
        }
        
        await viewModel.fetchUsers()
        XCTAssertEqual(viewModel.users.count, 6, "There should be 6 users within our data array")
        
        await viewModel.fetchNextSetOfUsers()
        XCTAssertEqual(viewModel.users.count, 12, "There should be 12 users within our data array")
        XCTAssertEqual(viewModel.page , 2, "Ther page should be 2 ")
        
        await viewModel.fetchUsers()//Sets values again and resests our values
       
    }
    
    func test_LastUserReturnsTrue() async {
        
        await viewModel.fetchUsers()
        let userData = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        let hasReachedEnd = viewModel.hasReachedEnd(of: userData.data.last!)
        
        XCTAssertTrue(hasReachedEnd, "last user should match")
    }
    
}
