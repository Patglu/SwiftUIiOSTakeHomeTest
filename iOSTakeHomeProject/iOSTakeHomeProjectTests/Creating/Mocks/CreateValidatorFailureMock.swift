import Foundation
@testable import iOSTakeHomeProject


struct CreateValidatorFailureMock: CreateValidatorImplimentation {
    
    func validate(_ person: iOSTakeHomeProject.NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}

