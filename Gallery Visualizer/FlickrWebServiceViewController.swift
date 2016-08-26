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
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error == nil {
                if let data = data { //optional binding
                    let parsedResult: AnyObject!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String: AnyObject],
                            photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String: AnyObject]] {
                                print(photoArray[0])
                        }
                    }
                    catch {
                        print("Could not parse the JSON data: \(data)")
                        return
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
    private func escapedParameters(parameters: [String: AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        }
        else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                
                let stringValue = "\(value)"
                
                let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            
            return "?\(keyValuePairs.joinWithSeparator("&"))"
        }
    }

}

