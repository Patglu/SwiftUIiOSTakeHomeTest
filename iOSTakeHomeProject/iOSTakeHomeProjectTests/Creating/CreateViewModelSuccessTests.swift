import XCTest
@testable import iOSTakeHomeProject


final class CreateViewModelSuccessTests: XCTestCase {
    
    private var networkingManagerMock: NetworkingManagerimplementation!
    private var validationMock: CreateValidatorImplimentation!
    private var viewModel: CreateViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingManagerMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorSuccessMock()
        viewModel = CreateViewModel(networkingManager: networkingManagerMock, validator: validationMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkingManagerMock = nil
        validationMock = nil
        viewModel = nil
    }
    
    func test_creating_user_with_no_errors() async {
        XCTAssertNil(viewModel.error, "There should be no error")
        
        defer {
            XCTAssertEqual(viewModel.state, .successful, "The state should be successful for newly created users")
            XCTAssertNil(viewModel.error, "There should be no error")
        }
        
        XCTAssertEqual(viewModel.person, NewPerson(), "There should be no new user created")
        await viewModel.create()
        
    }
}
