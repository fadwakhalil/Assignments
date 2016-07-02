//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/1/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {
    
    
    @IBOutlet weak var problem2Text: UITextView!
   
    @IBAction func problem2Button(sender: AnyObject) {
        problem2Text.text = "I am Happy!"
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