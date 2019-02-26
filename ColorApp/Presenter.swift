////
////  Presenter.swift
////  ColorApp
////
////  Created by Екатерина on 2/26/19.
////  Copyright © 2019 Екатерина. All rights reserved.
////
//
//import Foundation
//
//class Presenter {
//    init(updateRGBBlock: () -> (), updateCMYK) {
//        <#statements#>
//    }
//    func convertRGCtoCMYK(r:Float, g:Float, b:Float) {
//        
//        let r = r/255.0
//        let g = g/255.0
//        let b = b/255.0
//
//        self.colorView.layer.backgroundColor = (UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)).cgColor
//
//        let k = 1.0 - max(r, g, b)
//        let c = (1.0 - r - k)/(1.0 - k)
//        let m = (1.0 - g - k)/(1.0 - k)
//        let y = (1.0 - b - k)/(1.0 - k)
//
//        let cayla = Int(round(c * 100))
//        let magnets = Int(round(m * 100))
//        let yellow = Int(round(y * 100))
//        let black = Int(round(k * 100))
//
//        cmykCayalTF.text = "\(cayla)"
//        cmykCayalSlider.value = Float(cayla)
//        cmykMagnetTF.text = "\(magnets)"
//        cmykMagnetaSlider.value = Float(magnets)
//        cmykYellowTF.text = "\(yellow)"
//        cmykYellowSlider.value = Float(yellow)
//        cmykBlackTF.text = "\(black)"
//        cmykBlackSlider.value = Float(black)
//
//    }
//
//    func convertCMYKtoRGB(c: Float, m:Float, y:Float, k: Float) {
//
//        let c = c/100.0
//        let m = m/100.0
//        let y = y/100.0
//        let k = k/100.0
//
//        let r = 255.0 * (1.0 - c) * (1.0 - k)
//        let g = 255.0 * (1.0 - m) * (1.0 - k)
//        let b = 255.0 * (1.0 - y) * (1.0 - k)
//
//        self.colorView.layer.backgroundColor = (UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)).cgColor
//
//        rgbRedTF.text = "\(Int(round(r)))"
//        rgbRedSlider.value = r
//
//        rgbGreenTF.text = "\(Int(round(g)))"
//        rgbGreenSlider.value = g
//
//        rgbBlackTF.text = "\(Int(round(b)))"
//        rgbBlackSlider.value = b
//
//    }
//}
