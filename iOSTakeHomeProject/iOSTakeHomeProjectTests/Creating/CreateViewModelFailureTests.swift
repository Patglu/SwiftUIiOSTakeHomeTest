import XCTest
@testable import iOSTakeHomeProject

final class CreateViewModelFailureTests: XCTestCase {
    
    private var networkingManagerMock: NetworkingManagerimplementation!
    private var validationMock: CreateValidatorImplimentation!
    private var viewModel: CreateViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingManagerMock = NetworkingManagerCreateFailureMock()
        validationMock = CreateValidatorSuccessMock()
        viewModel = CreateViewModel(networkingManager: networkingManagerMock, validator: validationMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkingManagerMock = nil
        validationMock = nil
        viewModel = nil
    }
    
    func test_unsuccessful_response_sumission_state_is_unsuccessful() async throws {
        
        XCTAssertNil(viewModel.state, "No action has started it should be nil")
        
        defer {
            XCTAssertTrue(viewModel.hasError, "There should be an error")
            XCTAssertEqual(viewModel.state, .unsuccessful, "Unsuccessul when an error has been thrown ")
        }
        
        await viewModel.create()
    }
    
}
