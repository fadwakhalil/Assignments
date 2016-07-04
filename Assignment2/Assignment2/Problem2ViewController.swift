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

        let N = 10
        let M = N-1
        
        var arr = Array(count: N, repeatedValue: Array<Bool>(count: N, repeatedValue: false))
        
        for i in 0...M {
            for j in 0...M {
                if arc4random_uniform(3) == 1 {
                    arr[i][j] = true
                }
            }
        }
        
        var before = 0
        _ = 0
        for i in 0...M {
            for j in 0...M {
                if (arr[i][j] == true) {
                    before = before + 1
                }
            }
        }
        
        var i_top = 0
        var j_lef = 0
        var i_bot = 0
        var j_rig = 0
        var count = 0
        
        var res: [Bool] = [false,false,false,false,false,false,false,false]
        
        for i in 0...M {
            for j in 0...M {
                i_top = (i + M) % N
                j_lef = (j + M) % N
                i_bot = (i + 1) % N
                j_rig = (j + 1) % N
                
                res[0] = arr[i_top][j_lef]
                res[1] = arr[i_top][j]
                res[2] = arr[i_top][j_rig]
                res[3] = arr[i][j_lef]
                res[4] = arr[i][j_rig]
                res[5] = arr[i_bot][j_lef]
                res[6] = arr[i_bot][j]
                res[7] = arr[i_bot][j_rig]
                count = 0
                for k in 0...7 {
                    if (res[k] == true){
                        count = count + 1
                    }
                }
                switch count {
                case 0,1:
                    if (arr[i][j] == true){
                        arc4random_uniform(2) == 0 ? true: false
                    }
                    
                case 2:
                    if (arr[i][j] == true){
                        arr[i][j] = true
                    }
                case 3:
                    arr[i][j] = true
                default:
                    arr[i][j] = false
                    
                }
            }
        }
        
        var after = 0
        for i in 0...M {
            for j in 0...M {
                if (arr[i][j] == true) {
                    after = after + 1
                }
            }
        }
        
        let myString = "I am Happy!\n" + "Number of living cells in before: \(before)\n" + "Number of living cells in after: \(after)     "
        
        var myMutableString = NSMutableAttributedString()
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center

        myMutableString = NSMutableAttributedString(
            string: myString,
            attributes: [NSFontAttributeName:UIFont(
                name: "Chalkduster",
                size: 18.0)!])
        
        myMutableString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor.redColor(),
                                     range: NSRange(
                                        location:5,
                                        length:6))
        myMutableString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor.blueColor(),
                                     range: NSRange(
                                        location:45,
                                        length:3))
        myMutableString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor.greenColor(),
                                     range: NSRange(
                                        location:82,
                                        length:3))
        myMutableString.addAttribute(NSParagraphStyleAttributeName,
                                     value: style,
                                     range: NSRange(
                                        location:0,
                                        length:12))
        p2Text.attributedText = myMutableString
        
        
        
        

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