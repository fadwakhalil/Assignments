//
//  Engine.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/25/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

enum CellState {
    case Empty
    case Died
    case Born
    case Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Alive, .Born: return true
        case .Died, .Empty: return false
        }
    }
}

typealias Position = (row:Int, col:Int)
typealias Cell = (position: Position, state: CellState)

protocol GridProtocol{
    var rows: Int { get }
    var cols: Int { get }
    var cells: [Cell] { get }
    //init(rows: Int, cols: Int)
    func neighbors(pos: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
    subscript(row:Int, col:Int) -> CellState {get set}
    
}

class Grid: GridProtocol {
    
    var rows = 10
    var cols = 10

    var cells: [Cell]
    
    var living: Int { return cells.reduce(0) { return  $1.state.isLiving() ?  $0 + 1 : $0 } }
    var dead:   Int { return cells.reduce(0) { return !$1.state.isLiving() ?  $0 + 1 : $0 } }
    var alive:  Int { return cells.reduce(0) { return  $1.state == .Alive  ?  $0 + 1 : $0 } }
    var born:   Int { return cells.reduce(0) { return  $1.state == .Born   ?  $0 + 1 : $0 } }
    var died:   Int { return cells.reduce(0) { return  $1.state == .Died   ?  $0 + 1 : $0 } }
    var empty:  Int { return cells.reduce(0) { return  $1.state == .Empty  ?  $0 + 1 : $0 } }
    
    init (_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, cellInitializer(pos))
        }
    }
    
    
    typealias Position = (row:Int, col:Int)
    
    private static let offsets:[Position] = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1)
    ]
    
    func neighbors(pos: Position) -> [Position] {
        return Grid.offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }
    func livingNeighbors(position: Position) -> Int {
        return neighbors(position)
            .reduce(0) {
                self[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
    
    subscript (row:Int, col:Int) -> CellState {
        get {
            return cells[row*cols+col].state
        }
        set {
            cells[row*cols+col].state = newValue
        }
    }

}


protocol EngineProtocol {
    var rows: Int { get set }
    var cols: Int { get set }
    var grid: GridProtocol { get }
    var delegate: EngineDelegate? { get set }
    var refreshRate:  Double { get set }
    var refreshTimer: NSTimer? { get set }
    func step() -> GridProtocol
}

protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol)
}

typealias CellInitializer = (Position) -> CellState

class StandardEngine: EngineProtocol {
    static var _sharedInstance: StandardEngine = StandardEngine(10,10)
    static var sharedInstance: StandardEngine {
        get { return _sharedInstance }
    }
    var rows: Int = 10 {
        didSet {
            grid = Grid(self.rows, self.cols)
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
        }
    }
    var cols: Int = 10 {
        didSet {
            grid = Grid(self.rows, self.cols) 
            if let delegate = delegate {
                delegate.engineDidUpdate(grid)
            }
        }
        
    }

    var grid: GridProtocol
    
    var delegate: EngineDelegate?
    
    var refreshTimer: NSTimer?
    let timerEnd:NSTimeInterval = 10.0 //seconds to end the timer
    var timeCount:NSTimeInterval = 0.0 // counter for the timer
    
    var refreshRate: NSTimeInterval = 0.05 {
        didSet {
            if refreshRate != 0.0 {
                if let timer = refreshTimer { timer.invalidate() }
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                               target: self,
                                                               selector: sel,
                                                               userInfo: nil,
                                                               repeats: true)
            }
            else if let timer = refreshTimer {
                timer.invalidate()
                self.refreshTimer = nil
            }
        }
    }

    
    
    init(_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows,cols)
    }
    
    func step() -> GridProtocol {
        Grid(self.rows, self.cols).cells = Grid(self.rows, self.cols).cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
            3 where $0.state.isLiving():  return Cell($0.position, .Alive)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        grid = Grid(self.rows, self.cols)
        if let delegate = delegate { delegate.engineDidUpdate(grid) }
        return grid
    }
    
    @objc func timerDidFire(timer:NSTimer) {
        self.refreshTimer = timer
        if timeCount <= 0 {  //test for target time reached.
            timer.invalidate()
        } else if timeCount > 0 { //update the time on the clock if not reached
            timeCount = timeCount + refreshRate
        } else {
            timeCount = 0.0
        }
    }

}





