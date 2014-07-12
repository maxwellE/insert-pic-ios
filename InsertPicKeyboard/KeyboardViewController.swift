//
//  KeyboardViewController.swift
//  MorseCodeKeyboard
//
//  Created by Andrei Puni on 16/06/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit


class KeyboardViewController: UIInputViewController {
    
//    var nextKeyboardButton: UIButton!
    var dotButton: UIButton!
//    var dashButton: UIButton!
//    var deleteButton: UIButton!
//    var hideKeyboardButton: UIButton!
    
    var customInterface: UIView!
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        var nib = UINib(nibName: "CustomKeyboardInterface", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        customInterface = objects[0] as UIView
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customInterface)
     
        addKeyboardButtons()
    }
    
    func addKeyboardButtons() {
        addDot()
    }
    
    func addDot() {
        dotButton = UIButton.buttonWithType(.System) as UIButton
        dotButton.setTitle(".", forState: .Normal)
        dotButton.sizeToFit()
        dotButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        dotButton.addTarget(self, action: "didTapDot", forControlEvents: .TouchUpInside)
        
        dotButton.titleLabel.font = UIFont.systemFontOfSize(32)
        
        dotButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        dotButton.layer.cornerRadius = 5
        
        view.addSubview(dotButton)
        
        var dotCenterYConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        var dotCenterXConstraint = NSLayoutConstraint(item: dotButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        
        view.addConstraints([dotCenterXConstraint, dotCenterYConstraint])
    }
    
    @IBAction func didTapWeheartSwift() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText("Gif Added")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        var textColor: UIColor
        var proxy = textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
    }
    
}
