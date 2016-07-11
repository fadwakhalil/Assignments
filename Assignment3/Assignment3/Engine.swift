//
//  Engine1.swift
//  Assignment2
//
//  Created by Fadwa Khalil on 7/4/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class Engine: UIButton {
    
    func nieghbors (x: Int , y: Int, N: Int) -> [(Int,Int)] {
        let i = x
        let j = y
        let M = N - 1
        
        var i_top = 0
        var j_lef = 0
        var i_bot = 0
        var j_rig = 0
        
        i_top = (i + M) % N
        j_lef = (j + M) % N
        i_bot = (i + 1) % N
        j_rig = (j + 1) % N
        
        let ats: [(Int,Int)] = [
            (i_top,j_lef),
            (i_top,j),
            (i_top,j_rig),
            (i,j_lef),
            (i,j_rig),
            (i_bot,j_lef),
            (i_bot,j),
            (i_bot,j_rig)
        ]
        
        return ats
        
    }
    
    
    func step2(arr: [[Bool]] , N: Int) -> [[Bool]] {
        
        var narr = Array(count: N, repeatedValue: Array<Bool>(count: N, repeatedValue: false))
        var count = 0
        let M = N - 1
        
        var res: [Bool] = [false,false,false,false,false,false,false,false]
        
        for i in 0...M {
            for j in 0...M {
                let ats = nieghbors (i , y: j, N: N)
                
                res[0] = arr[ats[0].0][ats[0].1]
                res[1] = arr[ats[1].0][ats[1].1]
                res[2] = arr[ats[2].0][ats[2].1]
                res[3] = arr[ats[3].0][ats[3].1]
                res[4] = arr[ats[4].0][ats[4].1]
                res[5] = arr[ats[5].0][ats[5].1]
                res[6] = arr[ats[6].0][ats[6].1]
                res[7] = arr[ats[7].0][ats[7].1]
                count = 0
                for k in 0...7 {
                    if (res[k] == true){
                        count = count + 1
                    }
                }
                switch count {
                case 0,1:
                    narr[i][j] = false
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
    
}
