//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit
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
    func neighbors(pos:(rows:Int,cols:Int)) -> [(Int,Int)]
    //subscript(rows:Int, cols:Int) -> CellState {get set}
}

enum CellState: String {
    
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
}

/*
 Create a Swift protocol called EngineDelegate protocol which declares the following:
 
 engineDidUpdate(withGrid:) taking a GridProtocol object as an argument
*/

protocol EngineDelegate{
    func engineDidUpdate(withGrid: GridProtocol)
}


/*
 Create a class Grid which implements the GridProtocol and holds a collection of CellStates. 
 */

class Grid: GridProtocol {
    
    typealias Position = (row:Int, col:Int)
    var rows: Int, cols: Int

    
    let offsets:[(row:Int, col:Int)] = [
        (-1,-1), (-1, 0), (-1, 1),
        ( 0,-1),          ( 0, 1),
        ( 1,-1), ( 1, 0), ( 1, 1)
    ]
    
    
    func neighbors(pos:(rows:Int,cols:Int)) -> [(Int,Int)]  {
        return offsets.map { ((pos.rows + rows + $0.row) % rows, (pos.cols + cols + $0.col) % cols) }
    }
    
    typealias CellState = Bool
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
    /*
    subscript(rows: Int, column: Int) -> CellState {
        get {
            return grid[rows][cols]
            
        }
        
        set {
            grid[rows][cols] = newValue
        }
     
    }*/
    
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

protocol EngineProtocol{
    var delegate: EngineDelegate { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshTimer: NSTimer { get set }
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
    typealias Position = (row:Int, col:Int)
    typealias Cell = (position:Position, alive:CellState)

    var delegate: EngineDelegate
    var grid: GridProtocol
    var refreshRate: Double
    var refreshTimer: NSTimer

    
    func countLivingNeighbors(grid:[Cell], cell: Cell) -> Int {
        let xz:Grid
        return xz.neighbors((cell.position.row, cols:cell.position.col))
            .reduce(0) { grid[$1.0*cols + $1.1].alive == .Living ? $0 + 1: $0 }
    }
    
    func step(grid:[Cell]) -> [Cell] {
        return grid.map {
            switch countLivingNeighbors(grid, cell: $0) {
            case 3, 2 where $0.alive == .Living : return (($0.position.row,$0.position.col), .Living)
            default: return (($0.position.row,$0.position.col), .Died)
            }
        }
    }

    
}


//class StandardEngine: EngineProtocol {
//    
//    var grid: GridProtocol = Grid(rows:10, cols:10)
//    
//    func step() -> GridProtocol{
//        
//        //var narr = Grid(rows:10, cols:10)
//        var count = 0
//        let M = grid.rows - 1
//        
//        var res: [CellState] = [.Empty,.Empty,.Empty,.Empty,.Empty,.Empty,.Empty,.Empty]
//        
//        for i in 0...M {
//            for j in 0...M {
//                let ats = grid.neighbors (i , cols: j)
//                
//                res[0] = grid[ats[0].0,ats[0].1]
//                res[1] = grid[ats[1].0,ats[1].1]
//                res[2] = grid[ats[2].0,ats[2].1]
//                res[3] = grid[ats[3].0,ats[3].1]
//                res[4] = grid[ats[4].0,ats[4].1]
//                res[5] = grid[ats[5].0,ats[5].1]
//                res[6] = grid[ats[6].0,ats[6].1]
//                res[7] = grid[ats[7].0,ats[7].1]
//                count = 0
//                for k in 0...7 {
//                    if (res[k] == true){
//                        count = count + 1
//                    }
//                }
//                switch count {
//                case 0,1:
//                    grid[i,j] = false
//                case 2:
//                    if (grid[i,j] == true){
//                        grid[i,j] = true
//                    }
//                    else{
//                        grid[i,j] = false
//                    }
//                case 3:
//                    grid[i,j] = true
//                default:
//                    grid[i,j] = false
//                    
//                }
//            }
//        }
//        return grid
//    }
//}



protocol IncrementalProtocol {
    var rows: UInt { get set }
    var cols: UInt { get set }
    var delegate: IncrementalDelegateProtocol? { get set }
    func step() -> [[Bool]]
}

protocol IncrementalDelegateProtocol {
    func increment(increment: Incremental, didUpdateRows:UInt)
    func increment(increment: Incremental, didUpdateCols:UInt)
    
}

class Incremental : IncrementalProtocol {
    var rows: UInt = 0 {
        didSet {
            if let delegate = delegate {
                delegate.increment(self, didUpdateRows: self.rows)
            }
        }
    }
    var cols: UInt = 0
    var delegate: IncrementalDelegateProtocol?
    func step() -> [[Bool]] {
        return [[false]]
    }
}

class IncrementalDelegate: IncrementalDelegateProtocol {
    func increment(increment: Incremental, didUpdateRows: UInt) {
    }
    func increment(increment: Incremental, didUpdateCols: UInt) {
    }

}

class InstrumentationViewController: UIViewController, IncrementalDelegateProtocol {
    
    var increment: IncrementalProtocol!
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        increment = Incremental()
        increment.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func incrementRows(sender: AnyObject) {
            increment.rows += 10
    }
    @IBAction func cols(sender: AnyObject) {
            increment.cols += 10

    }

    func increment(increment: Incremental, didUpdateRows modelRows: UInt) {
        rows.text  = String(modelRows)
    }
    func increment(increment: Incremental, didUpdateCols modelCols: UInt) {
        cols.text  = String(modelCols)
    }
    
    
}
