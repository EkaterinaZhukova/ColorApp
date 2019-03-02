//
//  ViewController.swift
//  ColorApp
//
//  Created by Екатерина on 2/23/19.
//  Copyright © 2019 Екатерина. All rights reserved.
//

import UIKit
import ChromaColorPicker
import SnapKit

class ViewController: UIViewController {

    private var calculator: Calculator?

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
    
    //MARK: - lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator = Calculator()
        calculator?.delegate = self
        self.colorView.layer.cornerRadius = self.colorView.frame.height/2
        self.colorView.layer.borderColor = UIColor.gray.cgColor
        self.colorView.layer.borderWidth = 2
        configureSliders()
        self.navigationItem.title = "RGB <-> CMYK"
    }
    
    //MARK: - configuration methods
    
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
    
    //MARK: - rgb slider actions
    
    @objc func rgbRedSliderValueChanged(){
        rgbSliderSwiped(slider: rgbRedSlider)
    }
    
    @objc func rgbGreenSliderValueChanged(){
        rgbSliderSwiped(slider: rgbGreenSlider)
    }
    
    @objc func rgbBlackSliderValueChanged(){
        rgbSliderSwiped(slider: rgbBlackSlider)
    }
    
    //MARK: - cmyk slider actions
    
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
    
    //MARK: - rgb text fields actions

    @objc func rgbRedTFChanged() {
        return rgbTextFieldEdited(tf: rgbRedTF)
    }
    
    @objc func rgbGreenTFChanged() {
        return rgbTextFieldEdited(tf: rgbGreenTF)
    }
    
    @objc func rgbBlackTFChanged() {
        return rgbTextFieldEdited(tf: rgbBlackTF)
    }
    
    //MARK: - cmyk text fields actions

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
    
    //MARK: - common methods methods for changing value
    
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
        calculator?.convertRGBtoCMYK(r: Float(Int(rgbRedSlider.value)), g: Float(Int(rgbGreenSlider.value)), b: Float(Int(rgbBlackSlider.value)))
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
        calculator?.convertCMYKtoRGB(c: Float(Int(cmykCayalSlider.value)), m: Float(Int(cmykMagnetaSlider.value)), y: Float(Int(cmykYellowSlider.value)), k: Float(Int(cmykBlackSlider.value)))
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
        calculator?.convertRGBtoCMYK(r: Float(Int(rgbRedSlider.value)), g: Float(Int(rgbGreenSlider.value)), b: Float(Int(rgbBlackSlider.value)))
        
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
        calculator?.convertCMYKtoRGB(c: Float(Int(cmykCayalSlider.value)), m: Float(Int(cmykMagnetaSlider.value)), y: Float(Int(cmykYellowSlider.value)), k: Float(Int(cmykBlackSlider.value)))
        
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
    
    //MARK: - common hide/present actions
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func wasTappedColorView(_ sender: Any) {
        
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
    
    @IBAction func showHSVViewController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "hsvViewControllerId") as? HSVViewController {
            controller.onCloseBlock = {
                self.navigationController?.popViewController(animated: true)
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

//MARK: - ChromaColorPickerDelegate methods
extension ViewController: ChromaColorPickerDelegate {
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        self.colorView.backgroundColor = color
        
        let r = Int(round((color.cgColor.components?[0] ?? 0.0) * 255.0))
        let g = Int(round((color.cgColor.components?[1] ?? 0.0) * 255.0))
        let b = Int(round((color.cgColor.components?[2] ?? 0.0) * 255.0))
        
        updateRGB(r: r, g: g, b: b)
        calculator?.convertRGBtoCMYK(r: Float(r), g: Float(g), b: Float(b))
        colorPicker.superview?.removeFromSuperview()
    }
    
    
}

//MARK: - CalculatorDelegate methods
extension ViewController: CalculatorDelegate {
    
    func updateRGB(r: Int, g: Int, b: Int) {
        rgbRedTF.text = "\(r)"
        rgbRedSlider.value = Float(r)
        
        rgbGreenTF.text = "\(g)"
        rgbGreenSlider.value = Float(g)
        
        rgbBlackTF.text = "\(b)"
        rgbBlackSlider.value = Float(b)
    }
    
    func updateCMYK(c: Int, m: Int, y: Int, k: Int) {
        cmykCayalTF.text = "\(c)"
        cmykCayalSlider.value = Float(c)
        cmykMagnetTF.text = "\(m)"
        cmykMagnetaSlider.value = Float(m)
        cmykYellowTF.text = "\(y)"
        cmykYellowSlider.value = Float(y)
        cmykBlackTF.text = "\(k)"
        cmykBlackSlider.value = Float(k)
    }
    
    func updateColorView(with color: UIColor) {
        self.colorView.layer.backgroundColor = color.cgColor
    }
}
