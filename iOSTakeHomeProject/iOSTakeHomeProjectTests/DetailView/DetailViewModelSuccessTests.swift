import XCTest
@testable import iOSTakeHomeProject

final class DetailViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerimplementation!
    private var viewModel: DetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingMock = NetworkingManagerUserDetailResponseSuccessMock()
        viewModel = DetailViewModel(networkingManager: networkingMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkingMock = nil
        viewModel = nil
    }
    
    func test_with_successful_response_is_being_set() async throws {
        
        XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
        
        defer {
            XCTAssertFalse(viewModel.isLoading, "The view model should not be loading")
        }
        
        await viewModel.fetchDetails(for: 1)
        
        XCTAssertNotNil(viewModel.userInfo, "User info in the view Model should not be nil")
        
        let userDetailsData = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
        
        XCTAssertEqual(viewModel.userInfo, userDetailsData, "The response from our networking mock should match")
    }
   
}
