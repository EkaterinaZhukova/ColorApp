//
//  ColorModel.swift
//  ColorApp
//
//  Created by Екатерина on 2/23/19.
//  Copyright © 2019 Екатерина. All rights reserved.
//

import UIKit

class ColorModel: NSObject {
    let minValue: Float
    let maxValue: Float
    let amount: Int
    let colors: [UIColor]
    
    override init() {
        self.minValue = 0.0
        self.maxValue = 0.0
        self.amount = 0
        self.colors = [UIColor]()
    }
    
    init(minValue: Float, maxValue: Float, count: Int, colors: [UIColor]) {
        self.maxValue = maxValue
        self.minValue = minValue
        self.amount = count
        self.colors = colors
    }
    
}
