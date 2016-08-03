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
    var gridtitle: GridData?
    var commit:(String -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridName.text = gridtitle?.title
    }
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = gridName.text, commit = commit
            else { return }
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        engine.delegate = self
        gridView.points = gridtitle!.contents
        gridView.setNeedsDisplay()

    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        //gridView.setNeedsDisplay()
    }
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        gridView.setNeedsDisplay()
    }
    
}
