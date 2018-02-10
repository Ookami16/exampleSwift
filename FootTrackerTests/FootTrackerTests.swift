//
//  FootTrackerTests.swift
//  FootTrackerTests
//
//  Created by Mayte Mejia Palacios on 30/01/18.
//  Copyright © 2018 Mayte. All rights reserved.
//

import XCTest
@testable import FootTracker

class FootTrackerTests: XCTestCase {
    
        //MARK: Meal Class Test
    //Confirm that the Meal initializer returns a Meal object whe passed valid parameters.
    
    func testMealInitializationSucceeds(){
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    func testMealInitializationFails(){
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
    
        //Empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        //Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
    
}
