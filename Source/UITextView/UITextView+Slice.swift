//
//  UITextView+Slice.swift
//  ElegantUI
//
//  Created by John on 2019/7/8.
//  Copyright © 2019 ElegantUI. All rights reserved.
//

import UIKit

public extension UITextView {
    /// 裁剪文字（通常在 textViewDidChange 中调用）
    ///
    /// - Parameter limit: 限制字符
    /// - Parameter twoCountInFullWidthCharacter: 全角字符是否视为2个
    /// - Returns: 裁剪后的文字数量
    @discardableResult
    func slice(to limit: Int, twoCountInFullWidthCharacter: Bool = false) -> Int {
        if twoCountInFullWidthCharacter {
            if textCount(twoCountInFullWidthCharacter) > limit {
                guard let currentText = text else { return 0 }
                text = String(currentText.dropLast())
                return slice(to: limit, twoCountInFullWidthCharacter: twoCountInFullWidthCharacter)
            }
            return textCount(twoCountInFullWidthCharacter)
        }
        if text.count > limit {
            text = String(text.dropLast())
            return slice(to: limit)
        }
        return text.count
    }

    /// 文字数量
    /// - Parameter twoCountInFullWidthCharacter: 全角字符是否视为2个
    func textCount(_ twoCountInFullWidthCharacter: Bool) -> Int {
        guard let currentText = text else { return 0 }
        var length = 0
        for char in currentText {
            let addLength = twoCountInFullWidthCharacter ? 2: 1
            // 判断是否是半角字符，是的话+1 ，不是+2（英文/拉丁文等为半角，中文/韩文/日文等为全角）
            length += "\(char)".lengthOfBytes(using: String.Encoding.utf8) >= 3 ? addLength : 1
        }
        return length
    }
}
