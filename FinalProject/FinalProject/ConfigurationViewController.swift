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
        // Do any additional setup after loading the view.
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
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = configurations[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        } 
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
