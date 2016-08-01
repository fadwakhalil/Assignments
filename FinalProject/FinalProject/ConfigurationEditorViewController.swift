//
//  ConfigurationEditorViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit


class ConfigurationEditorViewController: UIViewController, EngineDelegate {
    
    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var gridName: UITextField!
    
    let engine = StandardEngine.sharedInstance
    
    var viaSegue = ""
    
    var gridtitle: GridData?
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridName.text = viaSegue
        
        if let name = gridtitle?.title {
            gridName?.text = name
        }
        
        //        let rightBarButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(saveButton(_:)))
        //        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let name = gridName?.text
        if gridtitle != nil {
            self.gridtitle?.title = name!
        } else {
            gridtitle = GridData(title:name!,contents:[])
        }
    }
    
    //    func saveButton(sender:UIBarButtonItem!)
    //    {
    //        print("save")
    //
    //
    //    }
    
    //    func gridTitle () {
    //    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    //    func dataChanged(newGrid: String) {
    //        self.gridName.text = nil
    //        self.navigationController?.popViewControllerAnimated(true)
    //    }
    
    
    func engineDidUpdate(withGrid: GridProtocol) {
        //gridView.setNeedsDisplay()
    }
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        gridView.setNeedsDisplay()
    }
    
}
