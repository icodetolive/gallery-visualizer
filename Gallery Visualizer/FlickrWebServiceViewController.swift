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
            
            //if an error occurs, print it and re-enable the UI
            func displayError(error: String) {
                print(error)
                print("URL at the time of error: \(url)")
                performUIUpdatesOnMain() {
                    self.setUIEnabled(true)
                }
            }
            
            //Was there an error?
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            //Was there any data returned?
            guard let data = data else { //optional binding using guard to check for the condition that doesn't exist
                displayError("No data was returned by the request!)")
                return
            }
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
            }
            catch {
                displayError("Could not parse the JSON data: \(data)")
                return
            }
        
            //Are the "photos" and "photo" keys part of our returned result?
            guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String: AnyObject],
                photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String: AnyObject]] else {
                    displayError("Cannot find keys: \(Constants.FlickrResponseKeys.Photos) and \(Constants.FlickrResponseKeys.Photo) in \(parsedResult)")
                    return
            }
            
            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
            let photoDictionary = photoArray[randomPhotoIndex] as? [String: AnyObject]
            
            guard let imageURLString = photoDictionary![Constants.FlickrResponseKeys.MediumPhotoURL] as? String else {
                displayError("Cannot find key: \(Constants.FlickrResponseKeys.MediumPhotoURL)")
                return
            }
            
            let photoTitle = photoDictionary![Constants.FlickrResponseKeys.Title] as? String
            let imageURL = NSURL(string: imageURLString)
            
            if let imageData = NSData(contentsOfURL: imageURL!) {
                performUIUpdatesOnMain() {
                    self.photoImageView.image = UIImage(data: imageData)
                    self.photoTitleLabel.text = photoTitle
                    self.setUIEnabled(true)
                }
            } else {
                displayError("Image doesn't exist at \(imageURL)")
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

