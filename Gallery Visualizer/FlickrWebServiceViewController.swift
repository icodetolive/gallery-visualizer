//
//  FlickrWebServiceViewController.swift
//  Gallery Visualizer
//
//  Created by Sugandha Naolekar on 7/31/16.
//  Copyright © 2016 icode. All rights reserved.
//

import UIKit

//https://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=f1f39280fd9ef2b4328e2381011da21d&gallery_id=5704-72157622566655097&extras=url_m&format=json&nojsoncallback=1

class FlickrWebServiceViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var grabImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func grabNewImage() {
        setUIEnabled(false)
        getImageFromFlickr()
    }
    
    private func setUIEnabled(enabled: Bool) {
        photoTitleLabel.enabled = enabled
        grabImageButton.enabled = enabled
        
        if enabled {
            grabImageButton.alpha = 1.0
        }
        //the button will be disabled until an image is downloaded 
        else {
            grabImageButton.alpha = 0.5
        }
    }
    
    private func getImageFromFlickr() {
        
        let methodParameters = [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.GalleryPhotosMethod,
            Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.GalleryID: Constants.FlickrParameterValues.GalleryID,
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumPhotoURL,
            Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.JsonFormat,
            Constants.FlickrParameterKeys.NoJsonCallback: Constants.FlickrParameterValues.DisableJsonCallback
        ]
        
        let urlString = Constants.Flickr.APIBaseURL + escapedParameters(methodParameters)
        
        print(urlString)
        
    }
    
    private func escapedParameters(parameters: [String: AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        }
        else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                
                var stringValue = "\(value)"
                
                let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            
            
            return "?\(keyValuePairs.joinWithSeparator("&"))"
        }
    }

}

