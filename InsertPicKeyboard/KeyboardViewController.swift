//
//  KeyboardViewController.swift
//  MorseCodeKeyboard
//
//  Created by Andrei Puni on 16/06/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit
import WebKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var webView: UIWebView
    
    let imageSearch = GiphyRequestManager()
    
    var nextKeyboardButton: UIButton!
    var nextImageButton: UIButton!
    var imageURLS: [NSURL]?
    var index: Int = 0
    var searchLen: Int?
    
    @IBAction func nextImage(sender: UIButton) {
        advanceGif()
    }
    
    @IBAction func prevImage(sender: UIButton) {
        previousGif()
    }
    
    func previousGif() {
        if index > 0 {
            index -= 1
        }
        else {
            index = (imageURLS?.count as Int) - 1
        }
        loadImage()
    }
    
    @IBAction func didPressPasteImage(sender: UIButton) {
        var proxy = textDocumentProxy as UITextDocumentProxy
        var i = 0
        while i < searchLen? {
            proxy.deleteBackward()
            i += 1
        }
        var urlText = imageURLS?[index].absoluteString
        proxy.insertText(urlText)
    }
    func advanceGif() {
        index += 1
        if index > imageURLS?.count {
            index = 0
        }
        loadImage()
    }
    
    func loadImage() {
        let url = imageURLS?[index] as NSURL
        var bodyStr = "<html><body style='background: url(\"".stringByAppendingFormat("%@\")", url)
        var final = bodyStr.stringByAppendingString(" no-repeat center center fixed;background-repeat: no-repeat;background-size: contain;'></body></html>")
        webView.loadHTMLString(final, baseURL: nil)
    }
    
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        didTapGifAdded()
    }
    
    func addKeyboardButtons() {
        addNextKeyboardButton()
    }
    
    func nextImage() {
        nextImageButton = UIButton.buttonWithType(.System) as UIButton
        nextImageButton.setTitle(">", forState: .Normal)
        
        
        
    }
    
    func addNextKeyboardButton() {
        nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        
        nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        view.addSubview(nextKeyboardButton)
        
        
        
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: +10.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item:nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -10.0)
        view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    @IBAction func didTapGifAdded() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        var searchText = proxy.documentContextBeforeInput as String?
        let withoutWhitespace = searchText?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        println(withoutWhitespace)
        if countElements(withoutWhitespace!) > 0{
            imageSearch.getGifUrlsForSearchText(withoutWhitespace!, successFunction: {(gifURLS: [NSURL]) -> Void in
                self.index = -1
                self.imageURLS = gifURLS
                self.searchLen = countElements(searchText!)
                if self.imageURLS?.count > 0 {
                    self.advanceGif()
                }
                else {
                    return
                }}, failureFunction: {(e: NSError?) -> Void in
                    println(e)})
        }
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
        
        nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    
}
