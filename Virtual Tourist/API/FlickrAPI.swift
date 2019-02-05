//
//  FlickerAPI.swift
//  Virtual Tourist
//
//  Created by ABDULRAHMAN ALRAHMA on 1/26/19.
//  Copyright © 2019 ABDULRAHMAN ALRAHMA. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FlickrAPI {
    struct Constants {
        static let API_KEY = "08c7316d179eb223b8de21eed30c0cd8"
        static let API_SECRET = "5d2e8b55cbd9637c"
        static let BASE_URL = "https://api.flickr.com/services/rest"
        static let FLICKR_SEARCH_METHOD = "flickr.photos.search"
        static let ACCURACY = 11
        static let NUM_OF_PHOTOS = 20
    }
    
    enum Sort: String, CaseIterable {
        case ate_posted_asc = "ate-posted-asc";
        case date_posted_desc = "date-posted-desc";
        case date_taken_asc = "date-taken-asc";
        case date_taken_desc = "date-taken-desc";
        case interestingness_desc = "interestingness-desc";
        case interestingness_asc = "interestingness-asc";
        case relevance
    }
    
    let a_a = 0
    static func getListOfPhotosIn(lat: Double, lon: Double, completionHandler: @escaping ([String]) -> Void) {
        
        let url = "\(Constants.BASE_URL)?api_key=\(Constants.API_KEY)&method=\(Constants.FLICKR_SEARCH_METHOD)&per_page=\(Constants.NUM_OF_PHOTOS)&format=json&nojsoncallback=?&lat=\(lat)&lon=\(lon)&sort=\(String(describing: Sort.allCases.randomElement()))"
        
        Alamofire.request(url).responseJSON { (response) in
            if((response.result.value) != nil) {
                
                let swiftyJsonVar = JSON(response.result.value!)
                var photosURL: [String] = []
                
                if let photos = swiftyJsonVar["photos"]["photo"].array {
                    for photo in photos {
                        let photoURL = "https://farm\(photo["farm"].stringValue).staticflickr.com/\(photo["server"].stringValue)/\(photo["id"])_\(photo["secret"]).jpg"
                        photosURL.append(photoURL)
                    }
                }
                completionHandler(photosURL)
            }
            //present error
        }
        
    }
}