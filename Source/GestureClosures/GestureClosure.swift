//
//  GestureClosure.swift
//  GGUI
//
//  Created by John on 2019/3/15.
//  Copyright © 2019 GGUI. All rights reserved.
//

import UIKit

private var HandlerKey: UInt8 = 0

internal extension UIGestureRecognizer {

    func setHandler<T: UIGestureRecognizer>(_ instance: T, handler: ClosureHandler<T>) {
        objc_setAssociatedObject(self, &HandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        handler.control = instance
    }

    func handler<T>() -> ClosureHandler<T> {
        return objc_getAssociatedObject(self, &HandlerKey) as! ClosureHandler
    }
}
