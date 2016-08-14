//
//  Constants.swift
//  Gallery Visualizer
//
//  Created by Sugandha Naolekar on 8/13/16.
//  Copyright © 2016 icode. All rights reserved.
//



//url :  https://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=f1f39280fd9ef2b4328e2381011da21d&gallery_id=5704-72157622566655097&extras=url_m&format=json&nojsoncallback=1
struct Constants {
    
    struct Flickr {
        static let ApiBaseURL = "https://api.flickr.com/services/rest/"
    }
    
    struct FlickrParameterKeys {
        static let Method = "method"
        static let APIKey = "api_key"
        static let GalleryID = "gallery_id"
        static let Extras = "extras"
        static let Format = "format"
        static let NoJsonCallback = "nojsoncallback"
    }
    
    struct FlickrParameterValues {
        static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
        static let APIKey = "7be204b1728a49147c0d0d68fe99bd2b"
        static let GalleryID = "66911286-72157647263150569"
        static let MediumPhotoURL = "url_m"
        static let JsonFormat = "json"
        static let DisableJsonCallback = "1" //1 means disable
    }
    
    struct FlickrResponseKeys {
        static let Photos = "photos"
        static let Photo = "photo"
        static let MediumPhotoURL = "url_m"
        static let Status = "stat"
        static let Title = "title"
    }
    
    struct FlickrResponseValues {
        static let OKStatus = "ok"
    }
}