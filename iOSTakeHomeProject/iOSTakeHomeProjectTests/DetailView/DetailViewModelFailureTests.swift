import XCTest
@testable import iOSTakeHomeProject

final class DetailViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerimplementation!
    private var viewModel: DetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingMock = NetworkingManagerUserDetailResponseFailureMock()
        viewModel = DetailViewModel(networkingManager: networkingMock)
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
        }
        
        await viewModel.fetchDetails(for: 1)
        XCTAssertNil(viewModel.userInfo, "The user should have no information")
        XCTAssertTrue(viewModel.hasError, "The view model should have an error")
        XCTAssertNotNil(viewModel.error, "The view model error should be set")
    }
}
