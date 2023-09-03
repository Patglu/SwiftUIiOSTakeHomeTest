import XCTest
@testable import iOSTakeHomeProject

class CreateViewModelValidationFailureTests: XCTestCase {
    
    private var networkingManagerMock: NetworkingManagerimplementation!
    private var validationMock: CreateValidatorImplimentation!
    private var viewModel: CreateViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingManagerMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorFailureMock()
        viewModel = CreateViewModel(networkingManager: networkingManagerMock, validator: validationMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkingManagerMock = nil
        validationMock = nil
        viewModel = nil
    }
    
    func test_with_invalid_form_submission_state_is_invalid() async {
        XCTAssertNil(viewModel.error, "There should be no error at initialisation")
        
        defer {
            XCTAssertTrue(viewModel.hasError, "An error should be thrown")
            XCTAssertEqual(viewModel.state, .unsuccessful, "Since we have an error we should have an unsuccessful state")
            XCTAssertNotNil(viewModel.error, "There should be an error ")
            XCTAssertEqual(viewModel.error, .validation(error: CreateValidator.CreateValidatorError.invalidFirstName), "The view model error should be invalid first name")
        }
        
        await viewModel.create()
    }
    
}
