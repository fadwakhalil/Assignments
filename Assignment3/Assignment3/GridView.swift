//
//  GridView.swift
//  Assignment3
//
//  Created by Fadwa Khalil on 7/8/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    @IBInspectable var livingColor: UIColor = UIColor.clearColor()
    @IBInspectable var emptyColor: UIColor = UIColor.clearColor()
    @IBInspectable var bornColor: UIColor = UIColor.clearColor().colorWithAlphaComponent(0.6)
    @IBInspectable var diedColor: UIColor = UIColor.clearColor().colorWithAlphaComponent(0.6)
    @IBInspectable var gridColor: UIColor = UIColor.clearColor()
    @IBInspectable var gridWidth: CGFloat = 2.0
    

    enum CellState: String {
        
        case Living = "Living"
        case Empty = "Empty"
        case Born = "Born"
        case Died = "Died"
        
        func description() -> String {
            switch self {
                
            default:
                return String(self.rawValue)
            }
        }
        
        static func allValues() -> [CellState] {
            return [.Living, .Empty, .Born, .Died]
        }
        
        func toggle(value:CellState)-> CellState {
            switch(value) {
            case .Empty, .Died: return .Living
            case .Living, .Born: return .Empty
            }
        }
    }
    
    func getCellStateColor(value:CellState) -> UIColor {
        switch value {
        case .Empty: return emptyColor
        case .Died: return diedColor
        case .Born: return bornColor
        default: return livingColor
        }
    }
   
    var grid = [[CellState.Empty]]

    @IBInspectable var rows: Int = 20 {
        didSet {
            var ncol = 0
            if grid.count > 0 {
                ncol = grid[0].count
                setNeedsDisplay()
            }
            
            grid = Array(count: rows, repeatedValue: Array<CellState>(count: ncol, repeatedValue: CellState.Empty))
        }
    }
    
    @IBInspectable var cols: Int = 20 {
        didSet {
            let nrow = grid.count
            grid = Array(count: nrow, repeatedValue: Array<CellState>(count: cols, repeatedValue: CellState.Empty))
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var fillColor = UIColor.clearColor()
    @IBInspectable var xProportion = CGFloat(0.8)
    @IBInspectable var widthProportion = CGFloat(0.002)
    var plusHeight: CGFloat = 0.0
    var plusWidth: CGFloat = 0.0
    
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        fillColor.setFill()
        path.fill()
        
        let lineWidth: CGFloat = sqrt(bounds.width*bounds.height) * widthProportion
        plusHeight = bounds.height * xProportion
        plusWidth = bounds.width * xProportion
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = lineWidth
        
        let x0: CGFloat = (bounds.width - plusWidth)/2
        let y0: CGFloat = (bounds.height - plusHeight)/2
        
        let xst: CGFloat = 0 + x0
        let xen: CGFloat = bounds.width - x0
        
        let yst: CGFloat = 0 + y0
        let yen: CGFloat = bounds.height - y0
        
        
        let stvert = plusWidth/CGFloat(cols)
        var x1: CGFloat  = 0
        var x2: CGFloat  = 0
        var y1: CGFloat  = 0
        var y2: CGFloat  = 0
        for i in 0...cols {
            x1 = stvert * CGFloat(i) + xst
            y1 = yst
            x2 = x1
            y2 = yen

            plusPath.moveToPoint(CGPoint(
                x:x1,
                y:y1))
        
            plusPath.addLineToPoint(CGPoint(
                x:x2,
                y:y2))
        }
        
        let sthor = plusHeight/CGFloat(rows)
        var x11: CGFloat  = 0
        var x22: CGFloat  = 0
        var y11: CGFloat  = 0
        var y22: CGFloat  = 0
        for i in 0...rows {
            x11 = xst
            y11 = sthor * CGFloat(i) + yst
            x22 = xen
            y22 = y11
            
            plusPath.moveToPoint(CGPoint(
                x:x11,
                y:y11))
            
            plusPath.addLineToPoint(CGPoint(
                x:x22,
                y:y22))
        }
     
        gridColor.setStroke()
        
        plusPath.stroke()
        
        let xlen = plusWidth/CGFloat(cols)
        let ylen = plusHeight/CGFloat(rows)
        var x: CGFloat  = 0
        var y: CGFloat  = 0
        for i in 0...rows-1 {
            y = (CGFloat(i) * ylen) + yst
            for j in 0...cols-1 {
                x = (CGFloat(j) * xlen) + xst
                let ovalPath = UIBezierPath(ovalInRect: CGRectMake(x, y, xlen, ylen))
                getCellStateColor(grid[i][j]).setFill()
                ovalPath.fill()
            }//for j
        }//for i
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position :CGPoint = touch.locationInView(self)
            print(position.x)
            print(position.y)
            let xlen = plusWidth/CGFloat(cols)
            let ylen = plusHeight/CGFloat(rows)
            let rown =  (position.x / xlen)
            let coln =  (position.y / ylen)
            print(rown)
            print (coln)
            
            let nx = CGFloat(rown) * xlen
            let ny = CGFloat(coln) * ylen
            
            let ovalPath = UIBezierPath(ovalInRect: CGRectMake(nx, ny, xlen, ylen))
            
            
            if ovalPath.containsPoint(position) {
                grid[Int(rown)][Int(coln)] = .Living
                getCellStateColor(grid[Int(rown)][Int(coln)]).setFill()
                ovalPath.fill()

            } else {
                grid[Int(rown)][Int(coln)] = .Empty
                
            }
            
        }
        
        
        
    }
    

}


