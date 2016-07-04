//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/3/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {
        
    @IBOutlet weak var p2Text: UITextView!
    @IBAction func p2Button(sender: AnyObject) {
        p2Text.text = "I am Happy!"
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.title = "Problem 2"
            // Do any additional setup after loading the view, typically from a nib.
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}