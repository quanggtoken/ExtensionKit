//
//  UITextView+Extension.swift
//  Copyright (c) 2015-2016 Moch Xiao (http://mochxiao.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

// MARK: - AssociationKey

private struct AssociationKey {
    fileprivate static var textViewTextObserver: String = "com.mochxiao.uitextview.textViewTextObserver"
}

// MARK: - TextObserver Extension

private extension UITextView {
    var textViewTextObserver: TextObserver {
        get { return ext.associatedObject(forKey: &AssociationKey.textViewTextObserver) as! TextObserver }
        set { ext.associate(retainObject: newValue, forKey: &AssociationKey.textViewTextObserver) }
    }
}

public extension Extension where Base: UITextView {
    public func setupTextObserver(maxLength: Int = 100, actionHandler: ((Int) -> ())? = nil) {
        let textObserver = TextObserver(maxLength: maxLength) { (remainCount) -> () in
            actionHandler?(remainCount)
        }
        textObserver.observe(textView: base)
        base.textViewTextObserver = textObserver
    }
}

// MARK: -

public extension Extension where Base: UITextView {
    public func scrollCursorToVisible() {
        let cursorLocation = base.selectedRange.location
        let range = NSMakeRange(0, cursorLocation)
        base.scrollRangeToVisible(range)
    }
}


