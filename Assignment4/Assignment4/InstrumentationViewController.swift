//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit
import Foundation


enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
}

protocol GridProtocol{
    var rows: Int { get set }
    var cols: Int { get set }
    init(rows: Int, cols: Int)
    func neighbors(pos:(row:Int,col:Int)) -> [(Int,Int)]
    subscript(row:Int, col:Int) -> CellState? {get set}
}

class Grid: GridProtocol {
    //var grid:[[CellState]] = [[CellState.Empty]]
    var cells : [CellState]?
    
    var rows: Int = 10
    var cols: Int = 10
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.cells = Array<CellState>(count: rows*cols, repeatedValue: .Empty)
    }
    
    typealias Position = (row:Int, col:Int)
    
    let offsets:[Position] = [
        (-1,-1), (-1, 0), (-1, 1),
        ( 0,-1),          ( 0, 1),
        ( 1,-1), ( 1, 0), ( 1, 1)
    ]
    
    func neighbors(pos:(row:Int, col:Int)) -> [(Int,Int)]  {
        return offsets.map { ((pos.row + rows + $0.row) % rows, (pos.col + cols + $0.col) % cols) }
    }
    
    subscript(row: Int, col: Int) -> CellState? {
        get {
            if cells!.count < Int(row*col) { return nil }
            return cells![Int(row * col + col)]
        }
        set (newValue) {
            if newValue == nil {  return }
            if row < 0 || row >= rows || col < 0 || col >= cols {  return }
            let cellRow = row * cols + col
            cells![Int(cellRow)] = newValue!
        }
    }
}


protocol EngineProtocol {
    var rows: Int { get set }
    var cols: Int { get set }
    var grid: GridProtocol? { get set}
    var delegate: EngineDelegate? { get set }
    func step() -> [[Bool]]
}

protocol EngineDelegate {
    //func engineDidUpdate(withGrid: GridProtocol)
    func engineDidUpdate(firsttab: InstrumentationViewController, didUpdateRows:Int)
    func engineDidUpdate(firsttab: InstrumentationViewController, didUpdateCols:Int)
}


class InstrumentationViewController : UIViewController,EngineProtocol {
    
    private static var _sharedInstance = InstrumentationViewController()
    static var sharedInstance: InstrumentationViewController {
        get {
            return _sharedInstance
        }
    }
    
    var grid: GridProtocol?
    
    var delegate: EngineDelegate?
    
    func step() -> [[Bool]] {
        return [[false]]
    }
    
    var rows: Int = 10 {
        didSet {
            if let delegate = delegate {
                delegate.engineDidUpdate(self, didUpdateRows: self.rows)
            }
        }
    }
    var cols: Int = 10 {
        didSet {
            if let delegate = delegate {
                delegate.engineDidUpdate(self, didUpdateCols: self.cols)
            }
        }
    }
    
}//EndClass

