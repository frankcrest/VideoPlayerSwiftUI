//
//  VideoPlayerSwiftUITests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Michael Gauthier on 2021-01-06.
//

import XCTest
@testable import VideoPlayerSwiftUI

class VideoPlayerSwiftUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_VideoPlayerViewModel_player_shouldBePausedWhenCallingPlayPause() {
        let vm = VideoPlayerViewModel(networkManager: NetworkManager())
        vm.isPlaying = true
        vm.playPause()
        XCTAssertEqual(vm.player.rate, 0)
    }
    
    func test_VideoPlayerViewModel_player_shouldBePlayingWhenCallingPlayPause() {
        let vm = VideoPlayerViewModel(networkManager: NetworkManager())
        vm.isPlaying = false
        vm.playPause()
        XCTAssertGreaterThan(vm.player.rate, 0)
    }
    
    func test_VideoPlayerViewModel_player_shouldGoToNextItem() {
        let vm = VideoPlayerViewModel(networkManager: NetworkManager())
        let exp = expectation(description: "Loading videos")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            vm.currentIndex = 0
            vm.next()
            guard let currentItem = vm.player.currentItem else { return }
            XCTAssertNotEqual(currentItem, vm.getAllPlayerItems()[0])
            XCTAssertEqual(currentItem, vm.getAllPlayerItems()[1])
            vm.next()
            XCTAssertEqual(currentItem, vm.getAllPlayerItems()[1])
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func test_VideoPlayerViewModel_shouldGoToPreviousItem() {
        let vm = VideoPlayerViewModel(networkManager: NetworkManager())
        let exp = expectation(description: "Loading videos")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            vm.currentIndex = 1
            vm.previous()
            guard let currentItem = vm.player.currentItem else { return }
            XCTAssertEqual(currentItem, vm.getAllPlayerItems()[0])
            XCTAssertNotEqual(currentItem, vm.getAllPlayerItems()[1])
            vm.previous()
            XCTAssertEqual(currentItem, vm.getAllPlayerItems()[0])
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
