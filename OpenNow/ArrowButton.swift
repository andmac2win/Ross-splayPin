//
//  ArrowButton.swift
//  SitFit
//
//  Created by Andy McDonald on 2/6/15.
//  Copyright (c) 2015 William Judd. All rights reserved.
//

import UIKit

@IBDesignable class ArrowButton: UIButton {
    
    @IBInspectable var strokeSize: CGFloat = 1
    @IBInspectable var strokeColor: UIColor = UIColor.darkGrayColor ()
    @IBInspectable var isRounded: Bool = true
    @IBInspectable var isReversed: Bool = false
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
        
    override func drawRect(rect: CGRect) {
    
        var context = UIGraphicsGetCurrentContext()
        
        strokeColor.set()
        
        if isRounded{
        
            CGContextSetLineWidth(context, strokeSize)
            CGContextSetLineCap(context, kCGLineCapRound)
        }
    
        if isReversed {
            
            CGContextMoveToPoint(context, rect.width - rightInset, topInset)
            CGContextAddLineToPoint(context, leftInset, rect.height / 2)
            CGContextAddLineToPoint(context, rect.width - rightInset, rect.height - bottomInset)
            
        }else{
            
            CGContextMoveToPoint(context, leftInset, topInset)
            CGContextAddLineToPoint(context, rect.width - rightInset, rect.height / 2)
            CGContextAddLineToPoint(context, leftInset, rect.height - bottomInset)
            
        }
    
    CGContextStrokePath(context)
    
        }
}

