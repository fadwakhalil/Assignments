//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/3/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Problem3ViewController: UIViewController {
    @IBOutlet weak var p3Text: UITextView!

    @IBAction func p3Button(sender: AnyObject) {
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        
        let myString = "I am Hungry!"
        
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(
            string: myString,
            attributes: [NSFontAttributeName:UIFont(
                name: "Chalkduster",
                size: 18.0)!])
        
        myMutableString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor.redColor(),
                                     range: NSRange(
                                        location:5,
                                        length:7))
        
        myMutableString.addAttribute(NSParagraphStyleAttributeName,
                                     value: style,
                                     range: NSRange(
                                        location:0,
                                        length:12))
        
        p3Text.attributedText = myMutableString

        
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

