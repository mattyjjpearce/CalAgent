//
//  addInfo.swift
//  CalorieTrackerDisUITests
//
//  Created by Matthew Pearce on 21/04/2021.
//

import XCTest

class addInfo: XCTestCase {

    private var app: XCUIApplication! //application allows us to refer to different types of elements in the app
    
    override func setUp() {
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func test_should_add_to_food_list(){
        
        //text field of inputting foods
        let foodNameTextField = self.app.textFields["foodNameTextField"]
        foodNameTextField.tap()
        foodNameTextField.typeText("Brownie \n")
        
        
        let newFoodFatTextField = self.app.textFields["newFoodFatTextField"]
        newFoodFatTextField.tap()
        newFoodFatTextField.typeText("10 \n")
        
        
        let addFoodButton = self.app.buttons["newFoodButton"]
        addFoodButton.tap()
        
//        let foodCount = self.app.accessibilityElements["foodListIdentifier"] //Checking the size of the list
        
        XCTAssertTrue(app.tables.staticTexts["Brownie"].exists)
        
       // XCTAssertEqual(1, foodCount)
        
    }

}
