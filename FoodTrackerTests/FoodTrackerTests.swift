//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Dmitry Parfenchik on 24/08/2015.
//
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    func testMealInitialization() {
        let potentialItem = Meal(name: "Some meal", rating: 4, photo: nil)
        XCTAssertNotNil(potentialItem)
        let noName = Meal(name: "", rating: 4, photo:nil)
        XCTAssertNil(noName, "No name expected")
        let badRating = Meal(name: "Starwars", rating: -1, photo: nil)
        XCTAssertNil(badRating, "Negative rating")
    }
}
