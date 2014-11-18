//
//  LayoutProxy.swift
//  AutoLayoutKit
//
//  Created by Florian Krüger on 17/11/14.
//  Copyright (c) 2014 projectserver.org. All rights reserved.
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

import Foundation
import UIKit

extension AutoLayoutKit {
  
  public class LayoutProxy: NSObject {
    
    let view: UIView
    var priority: UILayoutPriority
    
    init(view: UIView) {
      self.view = view
      self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
      self.priority = 1000
      super.init()
    }
    
    // MARK: Priority
    
    public func setPriorityRequired() {
      self.priority = 1000
    }
    
    public func setPriorityDefaultHigh() {
      self.priority = 750
    }
    
    public func setPriorityDefaultLow() {
      self.priority = 250
    }
    
    public func setPriorityFittingSizeLevel() {
      self.priority = 50
    }
    
    // MARK: DSL (set)
    
    public func set(attribute: NSLayoutAttribute, to constant: Float) -> (constraint: NSLayoutConstraint?, targetItem: UIView?) {
      return self.set(self.view, attribute: attribute, constant: constant, priority: self.priority)
    }
    
    // MARK: DSL (make)
    
    public func make(attribute: NSLayoutAttribute, equalTo relatedItem: AnyObject, s relatedAttribute: NSLayoutAttribute, times multiplier: Float = 1.0, plus constant: Float = 0.0, on targetView: UIView? = nil) -> (constraint: NSLayoutConstraint?, targetItem: UIView?) {
      return self.make(self.view, attribute: attribute, relation: .Equal, relatedItem: relatedItem, relatedItemAttribute: relatedAttribute, multiplier: multiplier, constant: constant, target: targetView, priority: self.priority)
    }
    
    // MARK: Core
    
    private func set(item: UIView, attribute: NSLayoutAttribute, constant: Float, priority: UILayoutPriority) -> (constraint: NSLayoutConstraint?, targetItem: UIView?) {
      return self.createLayoutConstraint(item, attribute: attribute, relation: .Equal, relatedItem: nil, relatedItemAttribute: .NotAnAttribute, multiplier: 1.0, constant: 0.0, target: item, priority: priority)
    }
    
    private func make(item: UIView, attribute: NSLayoutAttribute, relation: NSLayoutRelation, relatedItem: AnyObject, relatedItemAttribute: NSLayoutAttribute, multiplier: Float, constant: Float, target: UIView?, priority: UILayoutPriority) -> (constraint: NSLayoutConstraint?, targetItem: UIView?) {
      return self.createLayoutConstraint(item, attribute: attribute, relation: relation, relatedItem: relatedItem, relatedItemAttribute: relatedItemAttribute, multiplier: multiplier, constant: constant, target: target, priority: priority)
    }
    
    private func createLayoutConstraint(item: UIView, attribute: NSLayoutAttribute, relation: NSLayoutRelation, relatedItem: AnyObject?, relatedItemAttribute: NSLayoutAttribute, multiplier: Float, constant: Float, target aTarget: UIView?, priority: UILayoutPriority) -> (constraint: NSLayoutConstraint?, targetItem: UIView?) {
      
      let constraint = NSLayoutConstraint(
        item: item,
        attribute: attribute,
        relatedBy: relation,
        toItem: relatedItem,
        attribute: relatedItemAttribute,
        multiplier: CGFloat(multiplier),
        constant: CGFloat(constant))
      
      constraint.priority = priority
    
      if let target = aTarget {
        return self.installConstraint(constraint, onTarget: target)
      }
      
      let possibleTarget = AutoLayoutKit.findCommonSuperview(item, b: relatedItem as UIView?)
      if let target = possibleTarget {
        return self.installConstraint(constraint, onTarget: target)
      } else {
        return (nil, nil)
      }
    }
    
    private func installConstraint(constraint: NSLayoutConstraint, onTarget target: UIView) -> (constraint: NSLayoutConstraint?, targetItem: UIView?) {
      target.addConstraint(constraint)
      return (constraint, target)
    }
  }
}
