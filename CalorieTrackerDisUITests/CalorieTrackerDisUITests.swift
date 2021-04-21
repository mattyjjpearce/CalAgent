//
//  CalorieTrackerDisUITests.swift
//  CalorieTrackerDisUITests
//
//  Created by Matthew Pearce on 21/04/2021.
//

import XCTest
import SwiftUI

class CalorieTrackerDisUITests: XCTestCase {


        private var app: XCUIApplication! //application allows us to refer to different types of elements in the app
        
        override func setUp() {
            super.setUp()
            
            self.app = XCUIApplication()
            self.app.launch()
        }
        
        func testPersonName(){
            
            //text field of inputting foods
            let personNameTextField = self.app.textFields["personNameTextField"]
            personNameTextField.tap()
            personNameTextField.typeText("Name: ")
            
            XCTAssertEqual(personNameTextField.value as! String, "Name: ")
            
        }
    
    func testPersonAge(){
        
        //text field of inputting foods
        let personAgeTextField = self.app.textFields["personAgeTextField"]
        personAgeTextField.tap()
        personAgeTextField.typeText("21")
        
        XCTAssertEqual(personAgeTextField.value as! String, "21")
    }
    
    func testPersonHeight(){
        let personHeightTextField = self.app.textFields["personHeightTextField"]
        personHeightTextField.tap()
        personHeightTextField.typeText("170")
        
        XCTAssertEqual(personHeightTextField.value as! String, "170")
    }
    
    func testPersonWeight(){
        
        let personWeightTextField = self.app.textFields["personWeightTextField"]
        personWeightTextField.tap()
        personWeightTextField.typeText("160")
        
        XCTAssertEqual(personWeightTextField.value as! String, "160")
    }
    
    func testFatGoal(){
        
        let fatGoalTextField = self.app.textFields["fatGoalTextField"]
        fatGoalTextField.tap()
        fatGoalTextField.typeText("40")
        
        XCTAssertEqual(fatGoalTextField.value as! String, "40")
    }
    func testCarbGoal(){
        
        let carbGoalTextField = self.app.textFields["carbGoalTextField"]
        carbGoalTextField.tap()
        carbGoalTextField.typeText("40")
        
        XCTAssertEqual(carbGoalTextField.value as! String, "40")
    }
    func testProteinGoal(){
        let proteinGoalTextField = self.app.textFields["proteinGoalTextField"]
        proteinGoalTextField.tap()
        proteinGoalTextField.typeText("40")
        
        XCTAssertEqual(proteinGoalTextField.value as! String, "40")
    }
    
    func testToggle() {
            //Check toggle label is empty at first
            XCTAssertEqual(app.switches["toggle"].label, "Use Steps for Calories", "Toggle label was not empty when toggle is off")
            //Switch the toggle
            app.switches["toggle"].tap()
            //Check the toggle switch is now displayed
            XCTAssertEqual(app.switches["toggle"].label, "Use Steps for Calories", "Toggle label was not set when toggle is off")
            
        }

    
}

