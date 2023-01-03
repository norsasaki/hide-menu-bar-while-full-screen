//
//  hide_menu_bar_while_full_screenUITestsLaunchTests.swift
//  hide-menu-bar-while-full-screenUITests
//
//  Created by norsasaki_local on 2023/01/03.
//

import XCTest

final class hide_menu_bar_while_full_screenUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
