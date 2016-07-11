//
//  ViewController.swift
//  Assignment3
//
//  Created by Fadwa Khalil on 7/8/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet weak var Grid: GridView!
    @IBAction func pushButton(sender: UIButton) {
        
        
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
        
        
        Engine().step2(arr, N:N)
        

        var narr = Engine().step2(arr, N:N)
        
        
        var after = 0
        for i in 0...M {
            for j in 0...M {
                if (narr[i][j] == true) {
                    after = after + 1
                }
            }
        }
        
        print("Hello")
        GridView.CellState.allValues()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

