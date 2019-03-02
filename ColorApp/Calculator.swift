//
//  Calculator.swift
//  ColorApp
//
//  Created by Екатерина on 3/2/19.
//  Copyright © 2019 Екатерина. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    var delegate: CalculatorDelegate?
    
    func convertRGBtoCMYK(r:Float, g:Float, b:Float) {
        
        let r = r/255.0
        let g = g/255.0
        let b = b/255.0
        
        delegate?.updateColorView(with: (UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)))
        
        let k = 1.0 - max(r, g, b)
        let c = (1.0 - r - k)/(1.0 - k)
        let m = (1.0 - g - k)/(1.0 - k)
        let y = (1.0 - b - k)/(1.0 - k)
        
        let cayla = Int(round(c * 100))
        let magnets = Int(round(m * 100))
        let yellow = Int(round(y * 100))
        let black = Int(round(k * 100))
        
        delegate?.updateCMYK(c: cayla, m: magnets, y: yellow, k: black)
        
    }
    
    func convertCMYKtoRGB(c: Float, m:Float, y:Float, k: Float) {
        
        let c = c/100.0
        let m = m/100.0
        let y = y/100.0
        let k = k/100.0
        
        let r = 255.0 * (1.0 - c) * (1.0 - k)
        let g = 255.0 * (1.0 - m) * (1.0 - k)
        let b = 255.0 * (1.0 - y) * (1.0 - k)
        
        delegate?.updateColorView(with:(UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)))
        
        delegate?.updateRGB(r: Int(round(r)), g: Int(round(g)), b:  Int(round(b)))
    }
    
    func convertRGBtoHSV(r: Float, g: Float, b: Float) {
        
        let r = Double(r)/255.0
        let g = Double(g)/255.0
        let b = Double(b)/255.0
        
        let v = max(r, g, b)
        var s:Double
        var h = 0.0
        let temp = min(r, g, b)
        
        if (v == 0) {
            s = 0.0
        }
        else {
            s = Double((v - temp))/Double(v)
        }
        
        var cr = 0.0
        var cg = 0.0
        var cb = 0.0
        
        if (s == 0) {
            h = -1.0
        }
        else {
            cr = Double(v - r)/Double(v - temp)
            cg = Double(v - g)/Double(v - temp)
            cb = Double(v - b)/Double(v - temp)
        }
        
        if ( r == v) {
            h = cb - cg
        }
        if (g == v) {
            h = 2.0 + cr - cb
        }
        if ( b == v) {
            h = 4 + cg - cr
        }
        h *= 60.0
        if (h < 0.0) {
            h += 360
        }
        let h_res = Int(round(h))
        let s_res = Int(round(s * 100.0))
        let v_res = Int(round(v * 100.0))
        delegate?.updateHSV(h: h_res, s: s_res, v: v_res)
        delegate?.updateColorView(with: UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0))
        
    }
    
    func convertHSVtoRGB(h: Double, s: Double, v: Double) {
        let s = s / 100.0
        let v = v / 100.0
        
        let c = v * s
        let x = c * (1.0 - abs((h/60.0).truncatingRemainder(dividingBy: 2.0) - 1))
        let m = v - c
        
        var r = 0.0, g = 0.0, b = 0.0
        if (h >= 0 && h < 60) {
            r = (c + m)*255.0
            g = (x + m)*255.0
            b = (0 + m)*255.0
        }
        if (h >= 60 && h < 120) {
            r = (x + m)*255.0
            g = (c + m)*255.0
            b = (0 + m)*255.0
        }
        if (h >= 120 && h < 180) {
            r = (0 + m)*255.0
            g = (c + m)*255.0
            b = (x + m)*255.0
        }
        if (h >= 180 && h < 240) {
            r = (0 + m)*255.0
            g = (x + m)*255.0
            b = (c + m)*255.0
        }
        if (h >= 240 && h < 300) {
            r = (x + m)*255.0
            g = (0 + m)*255.0
            b = (c + m)*255.0
        }
        if (h >= 300 && h < 360) {
            r = (c + m)*255.0
            g = (0 + m)*255.0
            b = (x + m)*255.0
        }
        delegate?.updateRGB(r: Int(round(r)), g: Int(round(g)), b: Int(round(b)))
        delegate?.updateColorView(with: UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0))
        
    }

}

protocol CalculatorDelegate: AnyObject {
    func convertRGBtoCMYK(r:Float, g:Float, b:Float)
    func convertCMYKtoRGB(c: Float, m:Float, y:Float, k: Float)
    func updateRGB(r: Int, g: Int, b: Int)
    func updateCMYK(c: Int, m: Int, y: Int, k: Int)
    func updateHSV(h: Int, s: Int, v: Int)
    func updateColorView(with color:UIColor)
}

extension CalculatorDelegate {
    func convertRGBtoCMYK(r:Float, g:Float, b:Float) {}
    func convertCMYKtoRGB(c: Float, m:Float, y:Float, k: Float) {}
    func updateRGB(r: Int, g: Int, b: Int) {}
    func updateCMYK(c: Int, m: Int, y: Int, k: Int) {}
    func updateHSV(h: Int, s: Int, v: Int) {}
}
