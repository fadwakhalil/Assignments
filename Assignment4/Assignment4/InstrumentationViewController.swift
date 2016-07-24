//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit
import Foundation
/*
 an initializer accepting two ints, rows and cols
 two vars which are gettable only called rows and cols
 neighbors() as in Assignment 3 (i.e. taking a tuple of row, col, return an array of row,col tuples
 a subscript method which  allows you to get/set the CellState of a given row and column
*/
protocol GridProtocol{
    var rows: Int { get }
    var cols: Int { get }
    init(rows: Int, cols: Int)
    func neighbors(pos:(row:Int,col:Int)) -> [(Int,Int)]
    subscript(rows:Int, cols:Int) -> CellState {get set}
}

enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
}

/*
 Create a class Grid which implements the GridProtocol and holds a collection of CellStates. 
 */

class Grid: GridProtocol {
    
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
    
    var rows: Int, cols: Int

    typealias Position = (row:Int, col:Int)
    
    let offsets:[Position] = [
        (-1,-1), (-1, 0), (-1, 1),
        ( 0,-1),          ( 0, 1),
        ( 1,-1), ( 1, 0), ( 1, 1)
    ]

     var grid:[[CellState]] = [[CellState.Empty]]
    
    func neighbors(pos:(row:Int, col:Int)) -> [(Int,Int)]  {
        return offsets.map { ((pos.row + rows + $0.row) % rows, (pos.col + cols + $0.col) % cols) }
    }
    subscript(rows: Int, column: Int) -> CellState {
        get {
            return grid[rows][cols]
        }
        set {
            grid[rows][cols] = newValue
        }
    }
    
    

}

/*
 Create a Swift protocol called EngineProtocol which declares the following:
 
 a var delegate of type EngineDelegate
 a var grid of type GridProtocol (gettable only)
 a var refreshRate of type Double defaulting to zero
 a var refreshTimer of type NSTimer
 two vars rows and cols with no defaults
 an initializer taking rows and cols
 a func step()-> an object of type GridProtocol
 */

protocol EngineDelegate: class{
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol: class{
    var delegate: EngineDelegate? { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    //var refreshTimer: NSTimer { get set }
    var rows:Int { get set }
    var cols:Int { get set }
    init(rows: Int, cols: Int)
    func step() -> GridProtocol 
}

/*
 Create a class called StandardEngine which  implements the EngineProtocol method, implementing the Game Of Life rules as in Assignment 3 only  using funcs of StandardEngine rather than top-level functions.
 */

class StandardEngine: EngineProtocol {
    
    var rows:Int
    var cols:Int
    class singleton {
        var rows : Int = 10
        var cols : Int = 10
        static let sharedInstanceRows = singleton()
        static let sharedInstanceCols = singleton()
    }
        
    var delegate: EngineDelegate?
    
    func engineDidUpdate(withGrid: GridProtocol) {
        // do stuff like updating the UI
    }
    
//    var delegate: EngineDelegate? {
//        return delegate!.engineDidUpdate(self)
//    }
    
    var refreshRate: Double = 0
    
    
//    
//                let sel = #selector(StandardEngine.timerDidFire(_:))
//                 var refreshTimer:NSTimer?
//                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(1,
//                                                               target: self,
//                                                               selector: sel,
//                                                               userInfo: ["name": "fred"],
//                                                               repeats: true)


    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
    
    var grid: GridProtocol {
        return self.grid
    }
    
//    var grid: GridProtocol {
//        didSet {
//            if let delegate = delegate {
//                delegate.engineDidUpdate(self.grid)
//            }
//        }
//    }

    
    func step() -> GridProtocol {
        
        let N = grid.rows
        var narr = Array(count: N, repeatedValue: Array<CellState>(count: N, repeatedValue: .Empty))
        var count = 0
        let M = N - 1
        
        var res: [CellState] = [.Empty,.Empty,.Empty,.Empty,.Empty,.Empty,.Empty,.Empty]
        
        for i in 0...M {
            for j in 0...M {
                let ats = grid.neighbors ((i , j))
                
                res[0] = grid[(ats[0].0, ats[0].1)]
                res[1] = grid[(ats[1].0, ats[1].1)]
                res[2] = grid[(ats[2].0, ats[2].1)]
                res[3] = grid[(ats[3].0, ats[3].1)]
                res[4] = grid[(ats[4].0, ats[4].1)]
                res[5] = grid[(ats[5].0, ats[5].1)]
                res[6] = grid[(ats[6].0, ats[6].1)]
                res[7] = grid[(ats[7].0, ats[7].1)]
                count = 0
                for k in 0...7 {
                    if (res[k] == .Living){
                        count = count + 1
                    }
                }
                switch count {
                case 0,1:
                    narr[i][j] = .Empty
                case 2:
                    if (grid[(i,j)] == .Living){
                        narr[i][j] = .Living
                    }
                    else{
                        narr[i][j] = .Empty
                    }
                case 3:
                    narr[i][j] = .Living
                default:
                    narr[i][j] = .Empty
                    
                }
            }
        }
        return grid
    }
    
    
    //delegate?.engineDidUpdate(self)
    
}


class InstrumentationViewController: UIViewController {
    
    @IBOutlet weak var rowsStepper: UIStepper!
    @IBOutlet weak var colsStepper: UIStepper!
    @IBOutlet weak var rowsValue: UITextField!
    @IBOutlet weak var colsValue: UITextField!
    @IBAction func rowsStepperAction(sender: AnyObject) {
        rowsValue.text = "\(Int(rowsStepper.value))"
        NSNotificationCenter.defaultCenter().postNotificationName("rowValue", object: rowsStepper.value)
        //NSNotificationCenter.defaultCenter().postNotificationName("grid", object: StandardEngine.self)

    }
    @IBAction func colsStepperAction(sender: AnyObject) {
        colsValue.text = "\(Int(colsStepper.value))"
        NSNotificationCenter.defaultCenter().postNotificationName("colValue", object: colsStepper.value)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.rowsValue.text = String(StandardEngine.singleton.sharedInstanceRows.rows)
        self.colsValue.text = String(StandardEngine.singleton.sharedInstanceCols.cols)

    }
}
