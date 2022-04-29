//
//  MainPresenterTest.swift
//  MVP-Level OneUITests
//
//  Created by Андрей Антонен on 28.04.2022.
//

import XCTest
@testable import MVP_Level_One

class MockView: MainViewProtocol {
    var titleTest: String?
    
    func setGreeting(greeting: String) {
        self.titleTest = greeting
    }
    
    
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var person: Person!
    var presenter: MainPresenter!

    override func setUpWithError() throws {
        view = MockView()
        person = Person(firstName: "Baz", lastName: "Bar")
        presenter = MainPresenter(view: view, person: person)
    }

    override func tearDownWithError() throws {
        view = nil
        person = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view is not nil")
    }
}
