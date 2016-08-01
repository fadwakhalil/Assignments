//
//  ConfigurationEditorViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit


class ConfigurationEditorViewController: UIViewController, EngineDelegate, tableDelegate {
    
    var name:GridData?
    var commit: (String -> Void)?

    let SharedModel = ConfigurationViewController()
    
    //@IBOutlet weak var gridView: GridView!
    @IBOutlet weak var gridName: UITextField!
    
    let engine = StandardEngine.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(saveButton(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
//        let sel = #selector(gridTitle)
//        let center  = NSNotificationCenter.defaultCenter()
//        center.addObserver(self, selector: sel, name: "gridTitle", object: nil)
    }
    
    func saveButton(sender:UIBarButtonItem!)
    {
        print("save")
        SharedModel.addGrid(gridName.text!)

        guard let newText = gridName.text, commit = commit
            else { return }
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
    
    func gridTitle () {
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SharedModel.delegate = self
    }
    func dataChanged(newGrid: String) {
        self.gridName.text = nil
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    func engineDidUpdate(withGrid: GridProtocol) {
        //gridView.setNeedsDisplay()
    }
    func engineDidUpdate(withConfigurations: Array<GridData>) {
    }
    
}
