//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

protocol GridProtocol{
/*
 an initializer accepting two ints, rows and cols
 two vars which are gettable only called rows and cols
 neighbors() as in Assignment 3 (i.e. taking a tuple of row, col, return an array of row,col tuples
 a subscript method which  allows you to get/set the CellState of a given row and column
 */
    
    var rows: Int { get }
    var cols: Int { get }
    
    init(rows: Int, cols: Int)

    func neighbors (rows: Int , cols: Int, N: Int) -> [(Int,Int)]
    subscript(rows:Int, cols:Int) -> Bool {get set}
    
}
    
/*
 Create a Swift protocol called EngineDelegate protocol which declares the following:
 
 engineDidUpdate(withGrid:) taking a GridProtocol object as an argument
*/

protocol EngineDelegate{
    func engineDidUpdate(withGrid: GridProtocol, didUpdate:Int)
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
    init(rows: Int)
    init(cols: Int)
    func step(arr: GridProtocol)
}

/*
 Create a class Grid which implements the GridProtocol and holds a collection of CellStates. 
 */


class Grid: GridProtocol {
   
        enum CellState: String {
            
            case Living = "Living"
            case Empty = "Empty"
            case Born = "Born"
            case Died = "Died"
        }
    
    var rows: Int, cols: Int
    private var grid:[[Bool]]
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: false))
    }
    
    subscript(rows: Int, column: Int) -> Bool {
        get {
            return grid[rows][cols]
            
        }
        
        set {
            grid[rows][cols] = newValue
        }

        }
    func neighbors (rows: Int , cols: Int, N: Int) -> [(Int,Int)] {
        let i = rows
        let j = cols
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
 Create a class called StandardEngine which  implements the EngineProtocol method, implementing the Game Of Life rules as in Assignment 3 only  using funcs of StandardEngine rather than top-level functions.
 

class StandardEngine: EngineProtocol {
    
    
    func step2(arr: GridProtocol , N: Int) -> [[Bool]]{
        
        var narr = Array(count: N, repeatedValue: Array<Bool>(count: N, repeatedValue: false))
        var count = 0
        let M = N - 1
        
        var res: [Bool] = [false,false,false,false,false,false,false,false]
        
        for i in 0...M {
            for j in 0...M {
                let ats = neighbors (i , cols: j, N: N)
                
                res[0] = arr[ats[0].0][ats[0].1]
                res[1] = arr[ats[1].0][ats[1].1]
                res[2] = arr[ats[2].0][ats[2].1]
                res[3] = arr[ats[3].0][ats[3].1]
                res[4] = arr[ats[4].0][ats[4].1]
                res[5] = arr[ats[5].0][ats[5].1]
                res[6] = arr[ats[6].0][ats[6].1]
                res[7] = arr[ats[7].0][ats[7].1]
                count = 0
                for k in 0...7 {
                    if (res[k] == true){
                        count = count + 1
                    }
                }
                switch count {
                case 0,1:
                    narr[i][j] = false
                case 2:
                    if (arr[i][j] == true){
                        narr[i][j] = true
                    }
                    else{
                        narr[i][j] = false
                    }
                case 3:
                    narr[i][j] = true
                default:
                    narr[i][j] = false
                    
                }
            }
        }
        
        return narr
    }

    
}

*/
class InstrumentationViewController: UIViewController {

    var refreshRate: Double = 0
    
    var refreshTimer: NSTimer?
    var rows: Int?
    var cols: Int?
}
