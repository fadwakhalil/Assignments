//
//  ConfigurationViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

struct GridData {
    let title: String
    let contents: Array<Position>
    
    static func fromJSON(json: AnyObject) -> GridData! {
        if let dict = json as? Dictionary<String, AnyObject> {
            
            let title = dict["title"] as! String
            
            let contents = dict["contents"] as! Array<Array<Int>>
            let positions = contents.map({ (array: Array<Int>) -> Position in
                return Position(array.first!,array.last!)
            })
            
            return GridData(title: title, contents: positions)
        } else {
            return nil
        }
    }
}

protocol tableDelegate: class {
    func dataChanged(newGrid: String)
}

let SharedModel = ConfigurationViewController()

class ConfigurationViewController: UITableViewController, EngineDelegate {

    weak var delegate: tableDelegate?
    
    let engine = StandardEngine.sharedInstance
    
    var configurations: Array<GridData> {
        get {
            return engine.configurations
        }
        set {
            engine.configurations = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        let fetcher = Fetcher()
        
        fetcher.requestJSON(url) {(json, message) in
            let op = NSBlockOperation {
                if let json = json {
                self.configurations = (json as! Array<AnyObject>).map({ element in
                        return GridData.fromJSON(element)
                    })
                }
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        engine.delegate = self
        tableView.reloadData()
        
        NSNotificationCenter.defaultCenter().postNotificationName("gridTitle",
                                                                  object: nil,
                                                                  userInfo: nil)
    }
    
    func addGrid(gridtitle: String) {
        delegate?.dataChanged(gridtitle)
        tableView.reloadData()
        
    }
    @IBAction func addName(sender: AnyObject) {
        //configurations.append(sender)
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toTable" {
            let vc = segue.destinationViewController as! ConfigurationEditorViewController
            vc.name = GridData(title: "fadwa", contents: [Position(row: 0, col: 0)])
            print(vc.name)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = configurations[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            tableView.reloadData()
        } 
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromindexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        engine.configuration = configurations[indexPath.row]
    }
}
