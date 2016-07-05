//
//  Engine.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/4/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Engine: UIViewController {
    

    
        func step(arr: [[Bool]] , N: Int) -> [[Bool]] {
            
            var narr = Array(count: N, repeatedValue: Array<Bool>(count: N, repeatedValue: false))
            var i_top = 0
            var j_lef = 0
            var i_bot = 0
            var j_rig = 0
            var count = 0
            let M = N - 1
            
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
                            narr[i][j] = true
                        }
                        else{
                            narr[i][j] = false
                        }
                    case 3:
                        narr[i][j] = true
                    default:
                        narr[i][j] = false
                        
                    }
                }
            }
            
            return narr
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