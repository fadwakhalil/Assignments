//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

protocol GridProtocol{
    var rows: Int { get }
    var cols: Int { get }
    init(rows: Int, cols: Int)
    func neighbors (rows: Int , cols: Int, N: Int) -> [(Int,Int)]
    subscript(rows:Int, cols:Int) -> CellState {get set}
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
   
    
    var rows: Int, cols: Int
    private var grid:[[CellState]]
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
    }
    
    subscript(rows: Int, column: Int) -> CellState {
        get {
            return grid[rows][cols]
            
        }
        
        set {
            grid[rows][cols] = newValue
        }

        }
    func neighbors (rows: Int , cols: Int) -> [(Int,Int)] {
        let i = rows
        let j = cols
        let N=10
        let M = N - 1
        
        var i_top = 0
        var j_lef = 0
        var i_bot = 0
        var j_rig = 0
        
        i_top = (i + M) % N
        j_lef = (j + M) % N
        i_bot = (i + 1) % N
        j_rig = (j + 1) % N
        
        let ats: [(Int,Int)] = [
            (i_top,j_lef),
            (i_top,j),
            (i_top,j_rig),
            (i,j_lef),
            (i,j_rig),
            (i_bot,j_lef),
            (i_bot,j),
            (i_bot,j_rig)
        ]
        
        return ats
        
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

protocol EngineProtocol{
    var delegate: EngineDelegate { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshTimer: NSTimer { get set }
    
    init(rows: Int, cols: Int)
    func step() -> GridProtocol 
}

/*
 Create a class called StandardEngine which  implements the EngineProtocol method, implementing the Game Of Life rules as in Assignment 3 only  using funcs of StandardEngine rather than top-level functions.
 */

class StandardEngine: EngineProtocol {
    
    var grid: GridProtocol = Grid(rows:10, cols:10)
    
    func step() -> GridProtocol{
        
        var narr = Grid(rows:10, cols:10)
        var count = 0
        let M = grid.rows - 1
        
        var res: [CellState] = [.Empty,.Empty,.Empty,.Empty,.Empty,.Empty,.Empty,.Empty]
        
        for i in 0...M {
            for j in 0...M {
                let ats = grid.neighbors (i , cols: j)
                
                res[0] = grid[ats[0].0,ats[0].1]
                res[1] = grid[ats[1].0,ats[1].1]
                res[2] = grid[ats[2].0,ats[2].1]
                res[3] = grid[ats[3].0,ats[3].1]
                res[4] = grid[ats[4].0,ats[4].1]
                res[5] = grid[ats[5].0,ats[5].1]
                res[6] = grid[ats[6].0,ats[6].1]
                res[7] = grid[ats[7].0,ats[7].1]
                count = 0
                for k in 0...7 {
                    if (res[k] == true){
                        count = count + 1
                    }
                }
                switch count {
                case 0,1:
                    grid[i,j] = false
                case 2:
                    if (grid[i,j] == true){
                        grid[i,j] = true
                    }
                    else{
                        grid[i,j] = false
                    }
                case 3:
                    grid[i,j] = true
                default:
                    grid[i,j] = false
                    
                }
            }
        }
        return narr
    }
}


class InstrumentationViewController: UIViewController {
    @IBOutlet var dataRows: UITextField!

    /*@IBAction func incrementRows(sender: AnyObject) {
            example.rows += 10
    }
 */

}
