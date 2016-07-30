//
//  GridView.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/25/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit


@IBDesignable class GridView: UIView  {

    
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
    
    @IBOutlet weak var output: GridView!

    
    func cal_live (grid:GridProtocol, rows:Int, cols:Int) -> Int {
        var count = 0
        for i in 0...rows-1 {
            for j in 0...cols-1 {
                if grid[i,j] == .Alive  {
                    count = count + 1
                }
            }
        }
        return count
    }
    
    @IBAction func buttonPushed(sender: AnyObject) {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        var grid = StandardEngine.sharedInstance.grid

        let bef = cal_live (grid, rows:rows, cols:cols)
        grid = StandardEngine.sharedInstance.step()
        let aft = cal_live (grid, rows:rows, cols:cols)
        self.setNeedsDisplay()
        
        NSNotificationCenter.defaultCenter().postNotificationName("gridUpdated",
                                                                  object: nil,
                                                                  userInfo: ["bef" : bef, "aft" : aft])
        print (bef)
        print (aft)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshtime), name: "timerToggled", object: nil)

    }
    
    
    func refreshtime() {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        var grid = StandardEngine.sharedInstance.grid
        
        let bef = cal_live (grid, rows:rows, cols:cols)
        grid = StandardEngine.sharedInstance.step()
        let aft = cal_live (grid, rows:rows, cols:cols)
        self.setNeedsDisplay()
        
        print (bef)
        print (aft)
    }

    
    
    func getCellStateColor(value:CellState) -> UIColor {
            switch value {
            case .Empty: return emptyColor
            case .Died: return diedColor
            case .Born: return bornColor
            default: return livingColor
            }
    }
        

    override func drawRect(rect: CGRect) {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        var grid = StandardEngine.sharedInstance.grid
        let path = UIBezierPath(rect: rect)
        fillColor.setFill()
        path.fill()
        
        let lineWidth: CGFloat = sqrt(bounds.width*bounds.height) * widthProportion
        plusHeight = bounds.height * xProportion*0.8
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
//
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        var grid = StandardEngine.sharedInstance.grid

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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshtime), name: "timerToggled", object: nil)

    }
}



//
//
//    enum CellState: String {
//
//        case Living = "Living"
//        case Empty = "Empty"
//        case Born = "Born"
//        case Died = "Died"
//
//        func description() -> String {
//            switch self {
//
//            default:
//                return String(self.rawValue)
//            }
//        }
//
//        static func allValues() -> [CellState] {
//            return [.Living, .Empty, .Born, .Died]
//        }
//
//        func toggle(value:CellState)-> CellState {
//            switch(value) {
//            case .Empty, .Died: return .Living
//            case .Living, .Born: return .Empty
//            }
//        }
//    }
//
//    func getCellStateColor(value:CellState) -> UIColor {
//        switch value {
//        case .Empty: return emptyColor
//        case .Died: return diedColor
//        case .Born: return bornColor
//        default: return livingColor
//        }
//    }
//
//    var grid:[[CellState]] = [[CellState.Empty]]
//
//    @IBInspectable var rows: Int = 20 {
//        didSet {
//            var ncol = 0
//            if grid.count > 0 {
//                ncol = grid[0].count
//                setNeedsDisplay()
//            }
//
//            grid = Array(count: rows, repeatedValue: Array<CellState>(count: ncol, repeatedValue: CellState.Empty))
//        }
//    }
//
//    @IBInspectable var cols: Int = 20 {
//        didSet {
//            let nrow = grid.count
//            grid = Array(count: nrow, repeatedValue: Array<CellState>(count: cols, repeatedValue: CellState.Empty))
//            setNeedsDisplay()
//        }
//    }
//
//    @IBOutlet weak var view: GridView!
//        var arr = Array(count: rows, repeatedValue: Array<Bool>(count: cols, repeatedValue: false))
//        var bef = 0
//        var aft = 0
//
//        for i in 0...rows-1 {
//            for j in 0...cols-1 {
//                if grid[i][j].rawValue == "Living"  {
//                    arr[i][j] = true
//                    bef = bef + 1
//                }
//                else {
//                    arr[i][j] = false
//                }
//            }
//        }
//        arr = step.step()
//        for i in 0...rows-1 {
//            for j in 0...cols-1 {
//                if arr [i][j] == true  {
//                    grid[i][j] = .Living
//                    aft = aft + 1
//                }
//                else {
//                    grid[i][j] = .Empty
//                }
//            }
//        }
//        print (bef)
//        print (aft)
//        setNeedsDisplay()
//
//    }
//
//


