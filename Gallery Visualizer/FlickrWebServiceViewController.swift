//
//  FlickrWebServiceViewController.swift
//  Gallery Visualizer
//
//  Created by Sugandha Naolekar on 7/31/16.
//  Copyright © 2016 icode. All rights reserved.
//

import UIKit

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

}

