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
    private var calculator:Calculator?

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
    
    //MARK: - lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator = Calculator()
        calculator?.delegate = self
        self.navigationItem.title = "RGB <-> HSV"
        self.colorView.layer.cornerRadius = self.colorView.frame.height / 2
        self.colorView.layer.borderColor = UIColor.gray.cgColor
        self.colorView.layer.borderWidth = 2
    }

    
    //MARK: - common action methods
    
    func sliderSwiped(slider: UISlider) {
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
        
    }
    
    // MARK: - rgb text fields actions
    
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
    // MARK: - rgb sliders actions
    
    @IBAction func redSliderMoved(_ sender: Any) {
        self.sliderSwiped(slider: rgbRedSlider)
        rgbTohsv()
    }
    @IBAction func greenSliderMoved(_ sender: Any) {
        self.sliderSwiped(slider: rgbGreenSlider)
        rgbTohsv()

    }
    @IBAction func blueSliderMoved(_ sender: Any) {
        self.sliderSwiped(slider: rgbBlueSlider)
        rgbTohsv()

    }
    //MARK: - hsv text fields actions
    
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
    
    //MARK: - hsv sliders actions
    
    @IBAction func hsvHueSliderMoved(_ sender: Any) {
        sliderSwiped(slider: hsvHueSlider)
        hsvTorgb()
    }
    @IBAction func hsvSaturationSliderMoved(_ sender: Any) {
        sliderSwiped(slider: hsvSaturationSlider)
        hsvTorgb()
    }
    @IBAction func hsvValueSliderMoved(_ sender: Any) {
        sliderSwiped(slider: hsvValueSlider)
        hsvTorgb()
        
    }
 
    //MARK: - hide/present methods
    @IBAction func colorViewWasTapped(_ sender: Any) {
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 3
        neatColorPicker.hexLabel.textColor = UIColor.white
        let view = UIView.init(frame: self.view.bounds)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(neatColorPicker)
        neatColorPicker.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        self.view.addSubview(view)
    }
    
    @IBAction func hideKeyBoardAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        if let closeAction = onCloseBlock {
            closeAction()
        }
    }
 
    //MARK: - convert methods
    
    func rgbTohsv() {
        calculator?.convertRGBtoHSV(r: rgbRedSlider.value, g: rgbGreenSlider.value, b: rgbBlueSlider.value)
    }
    func hsvTorgb() {
        calculator?.convertHSVtoRGB(h:Double(hsvHueSlider.value), s: Double(hsvSaturationSlider.value), v: Double(hsvValueSlider.value))
    }
}

extension HSVViewController: ChromaColorPickerDelegate {
    //MARK: - ChromaColorPickerDelegate methods
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.colorView.backgroundColor = color
        
        let r = Int(round((color.cgColor.components?[0] ?? 0.0) * 255.0))
        let g = Int(round((color.cgColor.components?[1] ?? 0.0) * 255.0))
        let b = Int(round((color.cgColor.components?[2] ?? 0.0) * 255.0))
        
        updateRGB(r: r, g: g, b: b)
        rgbTohsv()
        colorPicker.superview?.removeFromSuperview()
    }
}


extension HSVViewController: CalculatorDelegate {
    //MARK: - CalculatorDelegate methods
    func updateColorView(with color: UIColor) {
        self.colorView.layer.backgroundColor = color.cgColor
    }
    
    func updateRGB(r: Int, g: Int, b: Int) {
        rgbRedTextField.text = "\(r)"
        rgbRedSlider.value = Float(r)
        
        rgbGreenTextField.text = "\(g)"
        rgbGreenSlider.value = Float(g)
        
        rgbBlueTextField.text = "\(b)"
        rgbBlueSlider.value = Float(b)
        
    }
    func updateHSV(h: Int, s: Int, v: Int) {
        hsvHueTextField.text = "\(h)"
        hsvSaturationTextField.text = "\(s)"
        hsvValueTextField.text = "\(v)"
        
        hsvHueSlider.value = Float(h)
        hsvSaturationSlider.value = Float(s)
        hsvValueSlider.value = Float(v)
        
    }
}
