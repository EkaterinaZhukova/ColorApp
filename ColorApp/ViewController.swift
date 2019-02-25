//
//  ViewController.swift
//  ColorApp
//
//  Created by Екатерина on 2/23/19.
//  Copyright © 2019 Екатерина. All rights reserved.
//

import UIKit
import ChromaColorPicker
class ViewController: UIViewController {

    
    @IBOutlet weak var modelSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var rgbStackView: UIStackView!
    @IBOutlet weak var rgbRedTF: UITextField!
    @IBOutlet weak var rgbRedSlider: UISlider!
    @IBOutlet weak var rgbGreenTF: UITextField!
    @IBOutlet weak var rgbGreenSlider: UISlider!
    @IBOutlet weak var rgbBlackTF: UITextField!
    @IBOutlet weak var rgbBlackSlider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var cmykCayalTF: UITextField!
    @IBOutlet weak var cmykCayalSlider: UISlider!
    @IBOutlet weak var cmykMagnetTF: UITextField!
    @IBOutlet weak var cmykMagnetaSlider: UISlider!
    @IBOutlet weak var cmykYellowTF: UITextField!
    @IBOutlet weak var cmykYellowSlider: UISlider!
    @IBOutlet weak var cmykBlackSlider: UISlider!
    @IBOutlet weak var cmykBlackTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorView.layer.cornerRadius = self.colorView.frame.height/2
       configureSliders()
    }
    
    @objc func segmentedControlChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            rgbStackView.isHidden = false
            break
        case 1:
            rgbStackView.isHidden = true
        default:
            break
        }
    }
    
    func configureSliders()  {
        rgbRedSlider.addTarget(self, action: #selector(rgbRedSliderValueChanged), for: .valueChanged)
        rgbGreenSlider.addTarget(self, action: #selector(rgbGreenSliderValueChanged), for: .valueChanged)
        rgbBlackSlider.addTarget(self, action: #selector(rgbBlackSliderValueChanged), for: .valueChanged)
        rgbRedTF.addTarget(self, action: #selector(rgbRedTFChanged), for: .editingChanged)
        rgbGreenTF.addTarget(self, action: #selector(rgbGreenTFChanged), for: .editingChanged)
        rgbBlackTF.addTarget(self, action: #selector(rgbBlackTFChanged), for: .editingChanged)
        
        cmykCayalSlider.addTarget(self, action: #selector(cmykCaylaSliderValueChanged), for: .valueChanged)
        cmykMagnetaSlider.addTarget(self, action: #selector(cmykMagnetaSliderValueChanged), for: .valueChanged)
        cmykYellowSlider.addTarget(self, action: #selector(cmykCYellowSliderValueChanged), for: .valueChanged)
        cmykBlackSlider.addTarget(self, action: #selector(cmykBlackSliderValueChanged), for: .valueChanged)
        
        cmykCayalTF.addTarget(self, action: #selector(cmykCaylaTFChanged), for: .editingChanged)
        cmykMagnetTF.addTarget(self, action: #selector(cmykMagnetsTFChanged), for: .editingChanged)
        cmykYellowTF.addTarget(self, action: #selector(cmykYellowTFChanged), for: .editingChanged)
        cmykBlackTF.addTarget(self, action: #selector(cmykBlackTFChanged), for: .editingChanged)

    }
    
    @objc func rgbRedSliderValueChanged(){
        rgbSliderSwiped(slider: rgbRedSlider)
    }
    
    @objc func rgbGreenSliderValueChanged(){
        rgbSliderSwiped(slider: rgbGreenSlider)
    }
    
    @objc func rgbBlackSliderValueChanged(){
        rgbSliderSwiped(slider: rgbBlackSlider)
    }
    
    @objc func cmykCaylaSliderValueChanged() {
        cmykSliderSwiped(slider: cmykCayalSlider)
    }
    
    @objc func cmykMagnetaSliderValueChanged() {
        cmykSliderSwiped(slider: cmykMagnetaSlider)
    }
    
    @objc func cmykCYellowSliderValueChanged() {
        cmykSliderSwiped(slider: cmykYellowSlider)
    }
    
    @objc func cmykBlackSliderValueChanged() {
        cmykSliderSwiped(slider: cmykBlackSlider)
    }
    
    @objc func rgbRedTFChanged() {
        return rgbTextFieldEdited(tf: rgbRedTF)
    }
    
    @objc func rgbGreenTFChanged() {
        return rgbTextFieldEdited(tf: rgbGreenTF)
    }
    
    @objc func rgbBlackTFChanged() {
        return rgbTextFieldEdited(tf: rgbBlackTF)
    }
    
    @objc func cmykCaylaTFChanged() {
        return cmykTextFieldChanged(tf: cmykCayalTF, slider: cmykCayalSlider)
    }

    @objc func cmykMagnetsTFChanged() {
        return cmykTextFieldChanged(tf: cmykMagnetTF, slider: cmykMagnetaSlider)
    }
    
    @objc func cmykYellowTFChanged() {
        return cmykTextFieldChanged(tf: cmykYellowTF, slider: cmykYellowSlider)
    }
    
    @objc func cmykBlackTFChanged() {
        return cmykTextFieldChanged(tf: cmykBlackTF, slider: cmykBlackSlider)
    }
    
    func rgbSliderSwiped(slider: UISlider) {
        switch slider {
        case rgbRedSlider:
            rgbRedTF.text = "\(Int(rgbRedSlider.value))"
            break
        case rgbGreenSlider:
            rgbGreenTF.text = "\(Int(rgbGreenSlider.value))"
            break
        case rgbBlackSlider:
            rgbBlackTF.text = "\(Int(rgbBlackSlider.value))"
            break
        default:
            break
        }
        convertRGCtoCMYK(r: Float(Int(rgbRedSlider.value)), g: Float(Int(rgbGreenSlider.value)), b: Float(Int(rgbBlackSlider.value)))
    }
    
    func cmykSliderSwiped(slider: UISlider) {
        switch slider {
        case cmykCayalSlider:
            cmykCayalTF.text = "\(Int(cmykCayalSlider.value))"
            break
        case cmykMagnetaSlider:
            cmykMagnetTF.text = "\(Int(cmykMagnetaSlider.value))"
            break
        case cmykYellowSlider:
            cmykYellowTF.text = "\(Int(cmykYellowSlider.value))"
            break
        case cmykBlackTF:
            cmykBlackTF.text = "\(Int(cmykBlackSlider.value))"
            break
        default:
            break
        }
        convertCMYKtoRGB(c: Float(Int(cmykCayalSlider.value)), m: Float(Int(cmykMagnetaSlider.value)), y: Float(Int(cmykYellowSlider.value)), k: Float(Int(cmykBlackSlider.value)))
    }
    
    func rgbTextFieldChanged(tf: UITextField, slider: UISlider) {
        guard let val = Int(tf.text!) else {
            return
        }
        var amount = val
        if (val < 0) {
            amount = 0
        }
        else if (val > 255) {
            amount = 255
        }
        tf.text = "\(amount)"
        slider.value = Float(amount)
        convertRGCtoCMYK(r: Float(Int(rgbRedSlider.value)), g: Float(Int(rgbGreenSlider.value)), b: Float(Int(rgbBlackSlider.value)))
        
    }
    func cmykTextFieldChanged(tf: UITextField, slider: UISlider) {
        guard let val = Int(tf.text!) else {
            return
        }
        var amount = val
        if (val < 0) {
            amount = 0
        }
        else if (val > 100) {
            amount = 100
        }
        tf.text = "\(amount)"
        slider.value = Float(amount)
        convertCMYKtoRGB(c: Float(Int(cmykCayalSlider.value)), m: Float(Int(cmykMagnetaSlider.value)), y: Float(Int(cmykYellowSlider.value)), k: Float(Int(cmykBlackSlider.value)))
        
    }
    
    func rgbTextFieldEdited(tf: UITextField) {
        switch tf {
        case rgbRedTF:
            return rgbTextFieldChanged(tf: rgbRedTF, slider: rgbRedSlider)
        case rgbGreenTF:
            return rgbTextFieldChanged(tf: rgbGreenTF, slider: rgbGreenSlider)
        case rgbBlackTF:
            return rgbTextFieldChanged(tf: rgbBlackTF, slider: rgbBlackSlider)
        case cmykCayalTF:
            return cmykTextFieldChanged(tf: cmykCayalTF, slider: cmykCayalSlider)
        case cmykMagnetTF:
            return cmykTextFieldChanged(tf: cmykMagnetTF, slider: cmykMagnetaSlider)
        case cmykYellowTF:
            return cmykTextFieldChanged(tf: cmykYellowTF, slider: cmykYellowSlider)
        case cmykBlackTF:
            return cmykTextFieldChanged(tf: cmykBlackTF, slider: cmykBlackSlider)
        default:
            return
        }
    }
    
    func convertRGCtoCMYK(r:Float, g:Float, b:Float) {
        
        let r = r/255.0
        let g = g/255.0
        let b = b/255.0
        
        self.colorView.layer.backgroundColor = (UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)).cgColor
        
        let k = 1.0 - max(r, g, b)
        let c = (1.0 - r - k)/(1.0 - k)
        let m = (1.0 - g - k)/(1.0 - k)
        let y = (1.0 - b - k)/(1.0 - k)
        
        let cayla = Int(round(c * 100))
        let magnets = Int(round(m * 100))
        let yellow = Int(round(y * 100))
        let black = Int(round(k * 100))
        
        cmykCayalTF.text = "\(cayla)"
        cmykCayalSlider.value = Float(cayla)
        cmykMagnetTF.text = "\(magnets)"
        cmykMagnetaSlider.value = Float(magnets)
        cmykYellowTF.text = "\(yellow)"
        cmykYellowSlider.value = Float(yellow)
        cmykBlackTF.text = "\(black)"
        cmykBlackSlider.value = Float(black)
        
    }
    
    func convertCMYKtoRGB(c: Float, m:Float, y:Float, k: Float) {
        
        let c = c/100.0
        let m = m/100.0
        let y = y/100.0
        let k = k/100.0
        
        let r = 255.0 * (1.0 - c) * (1.0 - k)
        let g = 255.0 * (1.0 - m) * (1.0 - k)
        let b = 255.0 * (1.0 - y) * (1.0 - k)
        
        self.colorView.layer.backgroundColor = (UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 1.0)).cgColor
        
        rgbRedTF.text = "\(Int(round(r)))"
        rgbRedSlider.value = r
        
        rgbGreenTF.text = "\(Int(round(g)))"
        rgbGreenSlider.value = g
        
        rgbBlackTF.text = "\(Int(round(b)))"
        rgbBlackSlider.value = b
        
    }

    
    @IBAction func wasTappedColorView(_ sender: Any) {
        
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
}

extension ViewController: ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.colorView.backgroundColor = color
        
        let r = Int(round((color.cgColor.components?[0] ?? 0.0) * 255.0))
        let g = Int(round((color.cgColor.components?[1] ?? 0.0) * 255.0))
        let b = Int(round((color.cgColor.components?[2] ?? 0.0) * 255.0))
        
        rgbRedTF.text = "\(r)"
        rgbRedSlider.value = Float(r)
        
        rgbGreenTF.text = "\(g)"
        rgbGreenSlider.value = Float(g)
        
        rgbBlackTF.text = "\(b)"
        rgbBlackSlider.value = Float(b)
        
        
        convertRGCtoCMYK(r: Float(r), g: Float(g), b: Float(b))
        
        colorPicker.superview?.removeFromSuperview()
    }
    
    
}
