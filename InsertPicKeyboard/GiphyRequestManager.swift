//
//  GiphyRequestManager.swift
//  InsertPicMobile
//
//  Created by Maxwell Elliott on 7/12/14.
//  Copyright (c) 2014 InsertPic. All rights reserved.
//

import Foundation

let _SingletonASharedInstance = GiphyRequestManager()

let gifLimit = 25

class GiphyRequestManager  {
    
    class var sharedInstance : GiphyRequestManager {
    return _SingletonASharedInstance
    }

    func getGifUrlsForSearchText(searchText: String, successFunction: ([NSURL]) -> Void, failureFunction: (NSError?) -> Void ) {
        let urlString = "http://www.getinsertpic.com/giphy_search/".stringByAppendingFormat("%@/%d.json", searchText, gifLimit).stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            var error: NSError?
            let responseDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            if (error) {
                failureFunction(error)
            } else {
                var gifURLArray = [NSURL]()
                let gifDataArray = responseDictionary["data"] as NSArray
                for gifData: NSDictionary! in gifDataArray {
                    let imageDictionary = gifData["images"] as NSDictionary
                    let imageOptionsDictionary = imageDictionary["fixed_height"] as NSDictionary
                    let finalUrl = imageOptionsDictionary["url"] as String
                    gifURLArray.append(NSURL(string: finalUrl))
                }
                successFunction(gifURLArray)
            }
        }
        task.resume()
    }
    
}