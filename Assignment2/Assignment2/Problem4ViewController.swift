//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/1/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {
    
    @IBAction func problem4Button(sender: AnyObject) {
        problem4Text.text = "I am Starving!"
    }
    @IBOutlet weak var problem4Text: UITextView!
        
    
   

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

