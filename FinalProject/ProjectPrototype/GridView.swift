//
//  GridView.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    let engine = StandardEngine.sharedInstance
    var rows: Int {
        get {
            if let configuration = engine.configuration {
                let intarray: Array<Int> = configuration.contents.map({
                    return $0.row
                })
                let value = (intarray.maxElement() ?? 20 ) + 1
                return value >= 20 ? value : 20
            }
            return engine.rows
        }
        set {
            engine.rows = newValue
        }
    }
    var cols: Int {
        get {
            if let configuration = engine.configuration {
                let intarray: Array<Int> = configuration.contents.map({
                    return $0.col
                })
                let value = (intarray.maxElement() ?? 20 ) + 1
                return value >= 20 ? value : 20
            }
            
            return engine.cols
        }
        set {
            engine.cols = newValue
        }
    }
    
    var grid: GridProtocol {
        get {
            if let configuration = engine.configuration {
                return Grid(rows,cols) { position in
                    if configuration.contents.contains({
                        return $0.row == position.row && $0.col == position.col
                    }) {
                        return .Alive
                    } else {
                        return .Empty
                    }
                }
                
            }
            
            return engine.grid
        }
        set {
            if let _ = engine.configuration {
                var array: Array<Position> = []
                for row in 0..<rows {
                    for col in 0..<cols {
                        if newValue[row,col] == .Alive {
                            array.append(Position(row,col))
                        }
                    }
                }
                engine.configurations[engine.configurationIndex!].contents = array
            } else {
                engine.grid = newValue
            }
            
        }
    }
    
    var points: [Position] {
        set {
            // set the row and col from that - double the maximum
            let newGrid = Grid(rows, cols) { position in
                return newValue.contains({ return position.row == $0.row && position.col == $0.col }) ? .Alive : .Empty
            }
            
            grid = newGrid
            
            // send EngineUpdate notification
            if let delegate = StandardEngine.sharedInstance.delegate {
                delegate.engineDidUpdate(grid)
            }
        }
        
        get {
            // return array of all alive cells (includes born, living, diseased)
            return grid.cells.reduce([]) { (array, cell) -> [Position] in
                if cell.state == .Alive {
                    return array + [cell.position]
                }
                return array
            }
        }
    }
    @IBInspectable var livingColor: UIColor = UIColor.clearColor()
    @IBInspectable var emptyColor: UIColor = UIColor.clearColor()
    @IBInspectable var bornColor: UIColor = UIColor.clearColor().colorWithAlphaComponent(0.6)
    @IBInspectable var diedColor: UIColor = UIColor.clearColor().colorWithAlphaComponent(0.6)
    @IBInspectable var gridColor: UIColor = UIColor.clearColor()
    @IBInspectable var gridWidth: CGFloat = 2.0
    
    @IBInspectable var fillColor = UIColor.clearColor()
    @IBInspectable var xProportion = CGFloat(0.8)
    @IBInspectable var widthProportion = CGFloat(0.002)
    
    var plusHeight: CGFloat = 0.0
    var plusWidth: CGFloat = 0.0
    var xst: CGFloat = 0.0
    var xen: CGFloat = 0.0
    var yst: CGFloat = 0.0
    var yen: CGFloat = 0.0
    var colWidth: CGFloat = 0.0
    var rowWidth: CGFloat = 0.0
    
    

    func getCellStateColor(value:CellState) -> UIColor {
        switch value {
        case .Empty: return emptyColor
        case .Died: return diedColor
        case .Born: return bornColor
        default: return livingColor
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
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
        xst = 0 + x0
        xen = bounds.width - x0
        yst = 0 + y0
        yen = bounds.height - y0
        
        
        colWidth = plusWidth/CGFloat(cols)
        rowWidth = plusHeight/CGFloat(rows)
        
        var x1: CGFloat  = 0
        var x2: CGFloat  = 0
        var y1: CGFloat  = 0
        var y2: CGFloat  = 0
        for i in 0...cols {
            x1 = colWidth * CGFloat(i) + xst
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
        
        var x11: CGFloat  = 0
        var x22: CGFloat  = 0
        var y11: CGFloat  = 0
        var y22: CGFloat  = 0
        for i in 0...rows {
            x11 = xst
            y11 = rowWidth * CGFloat(i) + yst
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
        
        var x: CGFloat  = 0
        var y: CGFloat  = 0
        for i in 0...rows-1 {
            y = (CGFloat(i) * rowWidth) + yst
            for j in 0...cols-1 {
                x = (CGFloat(j) * colWidth) + xst
                let ovalPath = UIBezierPath(ovalInRect: CGRectMake(x, y, colWidth, rowWidth))
                getCellStateColor(grid[i,j]).setFill()
                ovalPath.fill()
            }//for j
        }//for i
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let position :CGPoint = touch.locationInView(self)
            let xreal = position.x - xst
            let yreal = position.y - yst
            let rown =  Int (xreal / colWidth)
            let coln =  Int(yreal / rowWidth)
            if (rown >= 0 && rown < rows && coln >= 0 && coln < cols ) {
                grid[coln,rown] = .Alive //(CellState.Empty).isLiving()
                setNeedsDisplay()
            }
        }        
    }
}
