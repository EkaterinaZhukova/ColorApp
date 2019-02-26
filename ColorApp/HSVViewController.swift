//
//  HSVViewController.swift
//  ColorApp
//
//  Created by Екатерина on 2/26/19.
//  Copyright © 2019 Екатерина. All rights reserved.
//

import UIKit
import ChromaColorPicker

class HSVViewController: UIViewController {

    var onCloseBlock: (() -> ())?
    
    @IBOutlet weak var rgbRedSlider: UISlider!
    @IBOutlet weak var rgbRedTextField: UITextField!
    @IBOutlet weak var rgbGreenSlider: UISlider!
    @IBOutlet weak var rgbGreenTextField: UITextField!
    @IBOutlet weak var rgbBlueSlider: UISlider!
    @IBOutlet weak var rgbBlueTextField: UITextField!
    
    
    @IBOutlet weak var hsvHueSlider: UISlider!
    @IBOutlet weak var hsvHueTextField: UITextField!
    @IBOutlet weak var hsvSaturationSlider: UISlider!
    @IBOutlet weak var hsvSaturationTextField: UITextField!
    @IBOutlet weak var hsvValueSlider: UISlider!
    @IBOutlet weak var hsvValueTextField: UITextField!
    
    
    @IBOutlet weak var colorView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "RGB <-> HSV"
        self.colorView.layer.cornerRadius = self.colorView.frame.height / 2
        self.colorView.layer.borderColor = UIColor.gray.cgColor
        self.colorView.layer.borderWidth = 2
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        if let closeAction = onCloseBlock {
            closeAction()
        }
    }
    deinit {
        print("deinit")
    }
    func textFieldChanged(tf: UITextField, slider: UISlider, minVal: Int, maxVal: Int) {
        guard let val = Int(tf.text!) else {
            return
        }
        var amount = val
        if (val < minVal) {
            amount = minVal
        }
        else if (val > maxVal) {
            amount = maxVal
        }
        tf.text = "\(amount)"
        slider.value = Float(amount)
//        convertRGCtoCMYK(r: Float(Int(rgbRedSlider.value)), g: Float(Int(rgbGreenSlider.value)), b: Float(Int(rgbBlackSlider.value)))
    }
    
    func rgbSliderSwiped(slider: UISlider) {
        switch slider {
        case rgbRedSlider:
            rgbRedTextField.text = "\(Int(round(rgbRedSlider.value)))"
            break
        case rgbGreenSlider:
            rgbGreenTextField.text = "\(Int(round(rgbGreenSlider.value)))"
            break
        case rgbBlueSlider:
            rgbBlueTextField.text = "\(Int(round(rgbBlueSlider.value)))"
            break
        case hsvHueSlider:
            hsvHueTextField.text = "\(Int(round(hsvHueSlider.value)))"
        case hsvSaturationSlider:
            hsvSaturationTextField.text = "\(Int(round(hsvSaturationSlider.value)))"
        case hsvValueSlider:
            hsvValueTextField.text = "\(Int(round(hsvValueSlider.value)))"
        default:
            break
        }
//        convertRGCtoCMYK(r: Float(Int(rgbRedSlider.value)), g: Float(Int(rgbGreenSlider.value)), b: Float(Int(rgbBlackSlider.value)))
    }
    
    @IBAction func redSliderMoved(_ sender: Any) {
        self.rgbSliderSwiped(slider: rgbRedSlider)
        rgbTohsv()
        
    }
    @IBAction func greenSliderMoved(_ sender: Any) {
        self.rgbSliderSwiped(slider: rgbGreenSlider)
        rgbTohsv()

    }
    @IBAction func blueSliderMoved(_ sender: Any) {
        self.rgbSliderSwiped(slider: rgbBlueSlider)
        rgbTohsv()

    }
    
    @IBAction func redTFChanged(_ sender: Any) {
        self.textFieldChanged(tf: rgbRedTextField, slider: rgbRedSlider, minVal: 0, maxVal: 255)
        rgbTohsv()

    }
    @IBAction func greenRFChanged(_ sender: Any) {
        self.textFieldChanged(tf: rgbGreenTextField, slider: rgbGreenSlider, minVal: 0, maxVal: 255)
        rgbTohsv()

    }
    
    @IBAction func blueTFChanged(_ sender: Any) {
        self.textFieldChanged(tf: rgbBlueTextField, slider: rgbBlueSlider, minVal: 0, maxVal: 255)
        rgbTohsv()

    }
    
    @IBAction func colorViewWasTapped(_ sender: Any) {
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self //ChromaColorPickerDelegate
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 3
        neatColorPicker.hexLabel.textColor = UIColor.white
        let view = UIView.init(frame: self.view.bounds)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        //view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        view.addSubview(neatColorPicker)
        neatColorPicker.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        self.view.addSubview(view)
    }
    
    @IBAction func hideKeyBoardAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func hsvHueTfChanged(_ sender: Any) {
        self.textFieldChanged(tf: hsvHueTextField, slider: hsvHueSlider, minVal: 0, maxVal: 360)
        hsvTorgb()
    }
    @IBAction func hsvSaturationTfChanged(_ sender: Any) {
        self.textFieldChanged(tf: hsvSaturationTextField, slider: hsvSaturationSlider, minVal: 0, maxVal: 100)
        hsvTorgb()
    }
    @IBAction func hsvValueTfChanged(_ sender: Any) {
        self.textFieldChanged(tf: hsvValueTextField, slider: hsvValueSlider, minVal: 0, maxVal: 100)
        hsvTorgb()
    }
    @IBAction func hsvHueSliderMoved(_ sender: Any) {
        rgbSliderSwiped(slider: hsvHueSlider)
        hsvTorgb()
    }
    @IBAction func hsvSaturationSliderMoved(_ sender: Any) {
        rgbSliderSwiped(slider: hsvSaturationSlider)
        hsvTorgb()
    }
    @IBAction func hsvValueSliderMoved(_ sender: Any) {
        rgbSliderSwiped(slider: hsvValueSlider)
        hsvTorgb()

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
        hsvHueTextField.text = "\(h_res)"
        hsvSaturationTextField.text = "\(s_res)"
        hsvValueTextField.text = "\(v_res)"
        
        hsvHueSlider.value = Float(h_res)
        hsvSaturationSlider.value = Float(s_res)
        hsvValueSlider.value = Float(v_res)
        
        self.colorView.layer.backgroundColor = UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0).cgColor

    }
    func rgbTohsv() {
        self.convertRGBtoHSV(r: rgbRedSlider.value, g: rgbGreenSlider.value, b: rgbBlueSlider.value)
    }
    func hsvTorgb() {
        self.convertHSVtoRGB(h: Double(hsvHueSlider.value), s: Double(hsvSaturationSlider.value), v: Double(hsvValueSlider.value))
    }
    private func convertHSVtoRGB(h: Double, s: Double, v: Double) {
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
        rgbRedTextField.text = "\(Int(round(r)))"
        rgbGreenTextField.text = "\(Int(round(g)))"
        rgbBlueTextField.text = "\(Int(round(b)))"
        
        rgbRedSlider.value = Float(r)
        rgbGreenSlider.value = Float(g)
        rgbBlueSlider.value = Float(b)
        
        self.colorView.layer.backgroundColor = UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0).cgColor
        
    }
    
    //convertHSVtoRGB(h: 165.29, s: 0.8947, v: 0.4470)

    
    
}

extension HSVViewController: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.colorView.backgroundColor = color
        
        let r = Int(round((color.cgColor.components?[0] ?? 0.0) * 255.0))
        let g = Int(round((color.cgColor.components?[1] ?? 0.0) * 255.0))
        let b = Int(round((color.cgColor.components?[2] ?? 0.0) * 255.0))
        
        rgbRedTextField.text = "\(r)"
        rgbRedSlider.value = Float(r)
        
        rgbGreenTextField.text = "\(g)"
        rgbGreenSlider.value = Float(g)
        
        rgbBlueTextField.text = "\(b)"
        rgbBlueSlider.value = Float(b)
        
        rgbTohsv()
        colorPicker.superview?.removeFromSuperview()
    }
}
