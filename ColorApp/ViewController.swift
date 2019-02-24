//
//  ViewController.swift
//  ColorApp
//
//  Created by Екатерина on 2/23/19.
//  Copyright © 2019 Екатерина. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    
    @IBOutlet weak var rgbStackView: UIStackView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var stackOfSliders: UIStackView!
    let rgb = ColorModel(minValue: 0.0, maxValue: 255.0, count: 3, colors: [UIColor.red,UIColor.green, UIColor.black])
    let cmyk = ColorModel(minValue: 0, maxValue: 100, count: 4, colors: [UIColor.init(red: 0.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0), UIColor.init(red: 255/255.0, green: 0.0, blue: 255/255.0, alpha: 1.0),UIColor.init(red: 255/255.0, green: 255/255.0, blue: 0.0, alpha: 1.0),UIColor.black])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentedControl.addTarget(self, action: #selector(updateStackView), for: .valueChanged)
        self.generateView(for: self.getModel(), with: self.view.frame.width)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func updateStackView() {
        let model = getModel()
        generateView(for: model, with: self.view.frame.width)
    }
    
    func generateView(for model:ColorModel, with width: CGFloat) {
        clearStackView()
        for i in 0..<model.colors.count {
            let slider = UISlider()
            slider.tintColor = model.colors[i]
            slider.minimumValue = model.minValue
            slider.maximumValue = model.maxValue
            
            let textView = UITextField.init()
            textView.text = "255"
            let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 50.0))
            view.addSubview(textView)
            view.addSubview(slider)
            
            textView.snp.makeConstraints { (make) in
                make.width.equalTo(width * 0.15)
                make.left.equalTo(textView.superview?.snp.left ?? 0)
                make.top.equalTo(textView.superview?.snp.top ?? 0)
                make.bottom.equalTo(textView.superview?.snp.bottom ?? 0)
            }
            slider.snp.makeConstraints { (make) in
                make.top.equalTo(slider.superview?.snp.top ?? 0)
                make.bottom.equalTo(slider.superview?.snp.bottom ?? 0)
                make.right.equalTo(slider.superview?.snp.right ?? 0)
                make.left.equalTo(textView.snp.right)
            }
            self.stackOfSliders.addArrangedSubview(view)
        }
    }
    func clearStackView() {
        for view in self.stackOfSliders.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    func getModel() -> ColorModel {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            return self.rgb
        case 1:
            return self.cmyk
        default:
            return self.rgb
        }
    }


}

