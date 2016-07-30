//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var countText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addGridInfo), name: "gridUpdated", object: nil)
    }
    func addGridInfo(notification: NSNotification) {
        //print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let bef  = userInfo["bef"] as? Int,
            let aft     = userInfo["aft"] as? Int else {
                print("No Update found")
                
                return
        }
        
        countText.text = "Number of living cells in before: \(bef)\n"
            + "Number of living cells in after: \(aft) "
        
        
//        let alert = UIAlertController(title: "Notification!",
//                                      message:"Count before is \(bef) and Count After is \(aft)",
//                                      preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
//    let myString = "Number of living cells in before: \(before)\n"
//                    + "Number of living cells in after: \(after) "
//    
//    var myMutableString = NSMutableAttributedString()
//    
//    let style = NSMutableParagraphStyle()
//    style.alignment = NSTextAlignment.Center
//    
//    myMutableString = NSMutableAttributedString(
//    string: myString,
//    attributes: [NSFontAttributeName:UIFont(
//    name: "Chalkduster",
//    size: 18.0)!])
//    
//    myMutableString.addAttribute(NSForegroundColorAttributeName,
//    value: UIColor.redColor(),
//    range: NSRange(
//    location:5,
//    length:6))
//    myMutableString.addAttribute(NSForegroundColorAttributeName,
//    value: UIColor.blueColor(),
//    range: NSRange(
//    location:45,
//    length:3))
//    myMutableString.addAttribute(NSForegroundColorAttributeName,
//    value: UIColor.greenColor(),
//    range: NSRange(
//    location:82,
//    length:3))
//    myMutableString.addAttribute(NSParagraphStyleAttributeName,
//    value: style,
//    range: NSRange(
//    location:0,
//    length:12))
//    p2Text.attributedText = myMutableString
    
}
