//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/3/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    @IBOutlet weak var p4Text: UITextView!
    @IBAction func p4Button(sender: AnyObject) {
        p4Text.text = "I am Excited!"

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Problem 4"
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
