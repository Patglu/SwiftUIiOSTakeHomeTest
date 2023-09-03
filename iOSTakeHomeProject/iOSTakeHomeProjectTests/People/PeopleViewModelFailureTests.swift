import XCTest
@testable import iOSTakeHomeProject

final class PeopleViewModelFailureTests: XCTestCase {

    private var networkingMock:  NetworkingManagerimplementation!
    private var viewModel: PeopleViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingMock = NetworkManagerResponseFailureMock()
        viewModel = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkingMock = nil
        viewModel = nil
    }
   
    func test_WithUnseccesfulResponseErrorIsHandled() async {
        // testing if our viewmodel is loading and we are just testing to see if we have an error
        
        XCTAssertFalse(viewModel.isLoading, "The viewModel shouldn't be loading any data")
    
        defer {
            XCTAssertFalse(viewModel.isLoading, "The viewModel shouldnt be laoding any data" )
            XCTAssertEqual(viewModel.viewState, .finished, "The view model view state should be finished")
        }
        
        await viewModel.fetchUsers()

        XCTAssertTrue(viewModel.hasError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error should be set")
    }
}
