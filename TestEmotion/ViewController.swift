//
//  ViewController.swift
//  TestEmotion
//
//  Created by Brown Loaner on 9/17/16.
//  Copyright © 2016 Meme Moji Masters. All rights reserved.
//

import UIKit
import SwiftyJSON

var emotArray: [String] = ["anger", "contempt", "disgust", "fear", "happiness", "sadness", "surprise"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loadings the view, typically from a nib.
        print(emotArray[0])
        
        //var urlOxford: String?
        //var imageOxford: UIImage?
        
        //urlOxford = "http://bjstlh.com/image.php?pic=/data/wallpapers/231/WDF_2678368.jpg"
        
        let urlStringEmotion = NSString(format: "https://api.projectoxford.ai/emotion/v1.0/recognize");
        
        //let params = ["url" : "http://bjstlh.com/image.php?pic=/data/wallpapers/231/WDF_2678368.jpg"/*urlOxford!*/] as Dictionary<String, AnyObject>
        
        let emotionRequest : NSMutableURLRequest = NSMutableURLRequest()
        
        let session = NSURLSession.sharedSession()
        
        let urlStr = /*"http://static.eharmony.com/dating-advice/wp-content/uploads/images/across-the-pond-uk-and-us-views-on-dating-multiple-people-at-once-large.jpg"*/"http://efdreams.com/data_images/dreams/face/face-03.jpg"
        //urlStr = String(data: NSURL(string: NSString(format: "%@", urlStr)as String)!, encoding: NSUTF8StringEncoding)!
        print(urlStr)
        //let a = (NSString(format: "%@", urlStringEmotion)as String)
        let params = ["url":urlStr]//["url":NSString(format: "%@", urlStr)] as Dictionary<String, String>
        print(params)
        emotionRequest.URL = NSURL(string: NSString(format: "%@", urlStringEmotion)as String)
        emotionRequest.HTTPMethod = "POST"
        emotionRequest.timeoutInterval = 30
        emotionRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //emotionRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        emotionRequest.addValue("1fe171edcf9f4a0bbf6724f615e79175", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        let jsonBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        emotionRequest.HTTPBody = jsonBody//(jsonBody, forHTTPHeaderField: <#T##String#>)
        /*
        let task = session.dataTaskWithRequest(emotionRequest, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, err)
        })
        task.resume()
        */
        print(emotionRequest.URL)
        let dataTaskEmotion = session.dataTaskWithRequest(emotionRequest)
        {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedEmotionData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            print(httpResponse)
            let responseData = String(data: receivedEmotionData, encoding: NSUTF8StringEncoding)
            print(responseData)
            let json = JSON(data: receivedEmotionData)
            //print("JSON data is \(json)")
            
            

            
            var emotVals = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            var largestFace = 0;
            var largestFaceArea = 0.0
            //finds indexof largest face
            
            
            for i in 0..<json.count{
                let width =  json[i]["faceRectangle"]["width"].double!
                let height = json[i]["faceRectangle"]["height"].double!
                if width*height > largestFaceArea {
                    largestFaceArea = width*height
                    largestFace = i
                }
                
            }
            
            for i in 0..<7{
                let emotion: String = emotArray[i]
                emotVals[i] = json[largestFace]["scores"][emotion].double!
                print(emotVals[i])
            }
            
            //calculates largest face if multiple, converts json to only face of interest
            
            
            //Calculates emotions for largest face

            //var emotArray: [String] = ["anger", "contempt", "disgust", "fear", "happiness", "sadness", "surprise"]
            /*let anger = json[0]["scores"]["anger"].double
            let contempt = json[0]["scores"]["contempt"].double
            let disgust = json[0]["scores"]["disgust"].double
            let fear = json[0]["scores"]["fear"].double
            let happiness = json[0]["scores"]["happiness"].double
            let neutral = json[0]["scores"]["neutral"].double
            let sadness = json[0]["scores"]["sadness"].double
            let suprise = json[0]["scores"]["suprise"].double*/
        }
        let jsonData = String(data: jsonBody, encoding: NSUTF8StringEncoding)!
        print(jsonData)
        print(dataTaskEmotion)
        dataTaskEmotion.resume()
        
        
        
        print("finish")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

func takeMax(array: [Double]) -> (max: Double, emotion: String) {
    var currentMax = array[0]
    var curidx = 0
    var maxidx = 0
    var the_emotion = "null"
    for value in array[1..<array.count] {
        curidx = curidx + 1
        if (value > currentMax) {
            currentMax = value
            maxidx = curidx
        }
    }
    let emotionindex = maxidx % 7
    if emotionindex == 0{
        the_emotion = "anger"
    }
    else if emotionindex == 1{
        the_emotion = "contempt"
    }
    else if emotionindex == 2{
        the_emotion = "disgust"
    }
    else if emotionindex == 3{
        the_emotion = "fear"
    }
    else if emotionindex == 4{
        the_emotion = "happiness"
    }
    else if emotionindex == 5{
        the_emotion = "sadness"
    }
    else {
        the_emotion = "surprise"
    }
    
    return (currentMax, the_emotion)
}


print(takeMax([0.03,0.09,0.10,0.11,0.12,0.13,0.14,0.15]))

func takeMax(array:[[Double]]) -> (max: Double, emotion: String){
    var array1 = [Double]()
    for item in array{
        array1 = array1 + item
    }
    return takeMax(array1)
}    
    


}

