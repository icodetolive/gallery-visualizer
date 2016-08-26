//
//  GCDBlackBox.swift
//  Gallery Visualizer
//
//  Created by Sugandha Naolekar on 8/25/16.
//  Copyright © 2016 icode. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}