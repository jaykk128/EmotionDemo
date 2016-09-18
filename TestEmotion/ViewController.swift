//
//  ViewController.swift
//  TestEmotion
//
//  Created by Brown Loaner on 9/17/16.
//  Copyright © 2016 Meme Moji Masters. All rights reserved.
//

import UIKit
import SwiftyJSON

//var emotArray: [String] = ["anger", "contempt", "disgust", "fear", "happiness", "sadness", "surprise"]
//var maxCoef = 0.0
//var emotion = "neutral"
//
//enum Errors: ErrorType{
//    case HTTPError
//}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testArray :[String] = ["http://az616578.vo.msecnd.net/files/2015/11/25/6358402551031417651118703309_SUDDEN-FEAR_MAIN1520.jpg"]
        EmotionHandler.sharedInstance.getEmotion(testArray) { (finalEmote) in
            print(finalEmote)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}