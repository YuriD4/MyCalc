//
//  File.swift
//  
//
//  Created by Yuri Chukhlib on 25.07.2023.
//

import XCTest
import SwiftUI

@testable import MCSharedUI

class TabItemTests: XCTestCase {
    func testTabItemInitialization() {
        // Given
        let imageName = "testImage"
        let title = "Test Title"

        // When
        let tabItem = TabItem(imageName: imageName, title: title)

        // Then
        XCTAssertEqual(tabItem.imageName, imageName)
        XCTAssertEqual(tabItem.title, title)
    }
    
    func testTabItemBodyView() {
        // Given
        let imageName = "testImage"
        let title = "Test Title"
        let tabItem = TabItem(imageName: imageName, title: title)

        // When
        let tabItemView = tabItem.body

        // Then
        XCTAssertNotNil(tabItemView)
    }
}
