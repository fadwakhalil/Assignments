//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/1/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Problem3ViewController: UIViewController {
    
    
    @IBOutlet weak var problem3Text: UITextView!
    
    @IBAction func problem3Button(sender: AnyObject) {
        problem3Text.text = "I am Bored!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Problem 3"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
