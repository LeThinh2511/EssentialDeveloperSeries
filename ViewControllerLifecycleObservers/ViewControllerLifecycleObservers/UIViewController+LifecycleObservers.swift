//
//  UIViewController+LifecycleObservers.swift
//  ViewControllerLifecycleObservers
//
//  Created by ThinhLe on 3/28/20.
//  Copyright © 2020 ThinhLe. All rights reserved.
//

import UIKit

protocol UIViewControllerLifecycleObserver {
    func remove()
}

extension UIViewController {
    @discardableResult
    func onViewWillAppear(_ callBack: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifecycleObserver(viewWillAppearCallBack: callBack)
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewWillDisappear(_ callBack: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifecycleObserver(viewWillDisappearCallBack: callBack)
        add(observer)
        return observer
    }
    
    private func add(_ observer: UIViewController) {
        addChild(observer)
        view.addSubview(observer.view)
        observer.view.isHidden = true
        observer.didMove(toParent: self)
    }
}

private class ViewControllerLifecycleObserver: UIViewController, UIViewControllerLifecycleObserver {
    private var viewWillAppearCallBack: (() -> Void) = {}
    private var viewWillDisappearCallBack: () -> Void = {}
    
    convenience init(viewWillAppearCallBack: @escaping () -> Void = {}) {
        self.init()
        self.viewWillAppearCallBack = viewWillAppearCallBack
    }
    
    convenience init(viewWillDisappearCallBack: @escaping () -> Void = {}) {
        self.init()
        self.viewWillDisappearCallBack = viewWillDisappearCallBack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearCallBack()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearCallBack()
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
