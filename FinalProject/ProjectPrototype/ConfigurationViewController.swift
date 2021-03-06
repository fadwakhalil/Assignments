//
//  ConfigurationViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

struct GridData {
    var title: String
    var contents: Array<Position>
    
    static func fromJSON(json: AnyObject) -> GridData! {
        if let dict = json as? Dictionary<String, AnyObject> {
            
            let title = dict["title"] as! String
            
            let contents = dict["contents"] as! Array<Array<Int>>
            let positions = contents.map({ (array: Array<Int>) -> Position in
                return Position(array.first!,array.last!)
            })
            //print (positions)
            return GridData(title: title, contents: positions)
        } else {
            return nil
        }
    }
}

class ConfigurationViewController: UITableViewController, EngineDelegate {
    
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
                    //print(self.configurations.first)
                }
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        engine.configurationIndex = nil
        engine.delegate = self
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("cell") else { preconditionFailure("missing Default reuse identifier") }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("Error?")
        }
        nameLabel.text = configurations[row].title
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        guard let editingVC = segue.destinationViewController as? ConfigurationEditorViewController
            else { preconditionFailure("Error?") }
        
        engine.configurationIndex = editingRow
        editingVC.gridtitle = configurations[editingRow]
        editingVC.commit = {
            self.configurations[editingRow].title = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
        }
    }

    
    @IBAction func addConfiguration(sender: AnyObject) {
        configurations.append(GridData(title: "Add new grid...", contents: []))
    }
}
