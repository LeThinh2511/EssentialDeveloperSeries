//
//  ViewControllerLifecycleObserversTests.swift
//  ViewControllerLifecycleObserversTests
//
//  Created by ThinhLe on 3/28/20.
//  Copyright © 2020 ThinhLe. All rights reserved.
//

import XCTest
@testable import ViewControllerLifecycleObservers

class ViewControllerLifecycleObserversTests: XCTestCase {
    var sut: UIViewController!

    override func setUp() {
        super.setUp()
        sut = UIViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewWillAppearObserverIsAddedAsChild() {
        sut.onViewWillAppear {
        }
        
        XCTAssertEqual(sut.children.count, 1)
    }
    
    func testViewWillAppearObserversViewIsAddedAsSubview() {
        sut.onViewWillAppear {
        }
        
        let observer = sut.children.first
        XCTAssertEqual(observer?.view.superview, sut.view)
    }
    
    func testViewWillAppearObserverViewIsHidden() {
        sut.onViewWillAppear {
        }
        
        let observer = sut.children.first
        XCTAssertEqual(observer?.view.isHidden, true)
    }
    
    func testViewWillAppearObserverFiresCallBack() {
        var count = 0
        sut.onViewWillAppear {
            count += 1
        }
        let observer = sut.children.first
        XCTAssertEqual(count, 0)
        
        observer?.viewWillAppear(true)
        XCTAssertEqual(count, 1)
        
        observer?.viewWillAppear(true)
        XCTAssertEqual(count, 2)
    }
    
    func testCanRemoveViewWillAppearObserver() {
        sut.onViewWillAppear {
        }.remove()
        XCTAssertEqual(sut.children.count, 0)
    }
    
    func testCanRemoveViewWillAppearObserverView() {
        sut.onViewWillAppear {
        }.remove()
        XCTAssertEqual(sut.view.subviews.count, 0)
    }
    
    func testViewWillDisappearObserverAddedAsChild() {
        sut.onViewWillDisappear {
        }
        XCTAssertEqual(sut.children.count, 1)
    }

    func testViewWillDisappearObserverViewAddedAsSubView() {
        sut.onViewWillDisappear {
        }
        let observer = sut.children.first
        XCTAssertEqual(observer?.view.superview, sut.view)
    }
    
    func testViewWillDisappearFiresCallBack() {
        var callCount = 0
        sut.onViewWillDisappear {
            callCount += 1
        }
        XCTAssertEqual(callCount, 0)
        let observer = sut.children.first
        observer?.viewWillDisappear(false)
        XCTAssertEqual(callCount, 1)
    }
    
    func testCanRemoveViewWillDisappearObserver() {
        let observer = sut.onViewWillDisappear {
        }
        observer.remove()
        XCTAssertEqual(sut.children.count, 0)
    }
    
    func testCanRemoveViewWillDisappearObserverView() {
        let observer = sut.onViewWillDisappear {
        }
        observer.remove()
        XCTAssertEqual(sut.view.subviews.count, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
