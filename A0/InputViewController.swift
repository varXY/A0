//
//  InputViewController.swift
//  D4
//
//  Created by 文川术 on 4/4/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

protocol InputViewControllerDelegate: class {
	func inputTextViewDidReturn(index: Int, text: String)
}

class InputViewController: UIViewController {

	var index: Int! {
		didSet {
			switch index {
			case 0: leftTitle = "GOAL"
            case 1: leftTitle = "OUTCOME"
			case 2: leftTitle = "LESSON"
			default: break
			}
		}
	}

	var oldText = ""
	var leftTitle = ""
	var textView: UITextView!

	weak var delegate: InputViewControllerDelegate?
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.barTintColor = UIColor.colorOfStatus("\(index)")

        let titleItem = UIBarButtonItem(customView: TitleLabel(text: leftTitle))
        navigationItem.leftBarButtonItem = titleItem
        
        let doneButton = UIBarButtonItem(image: UIImage(named: "down"), style: .Plain, target: self, action: #selector(doneEditing))
        navigationItem.rightBarButtonItem = doneButton

		let factor: CGFloat = ScreenHeight != 480 ? 0.38 : 0.3
		textView = UITextView(frame: CGRectMake(0, 15, ScreenWidth, ScreenHeight * factor + 45))
		textView.backgroundColor = UIColor.clearColor()
		textView.tintColor = UIColor.colorOfStatus("\(index)")
//		textView.textColor = UIColor.blackColor()
//		textView.font = UIFont.systemFontOfSize(25)
//		textView.textAlignment = .Center
		textView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
		textView.delegate = self
		view.addSubview(textView)
        
        textView.attributedText = textWithStyle(oldText, colorStatus: "\(index)")
        textView.scrollRangeToVisible(NSMakeRange(textView.attributedText.length - 1, textView.attributedText.length))
        textView.typingAttributes = textAttributes("\(index)")

	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		textView.becomeFirstResponder()
    }
    
    func doneEditing() {
        textView.resignFirstResponder()
        back()
    }

	func addBackButton() {
		let backButton = UIButton(type: .System)
		backButton.frame = CGRectMake(0, ScreenHeight / 2 + 20, ScreenWidth, ScreenHeight / 2 - 20)
		backButton.setImage(UIImage(named: "Pointer"), forState: .Normal)
		backButton.transform = CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))
		backButton.addTarget(self, action: #selector(back), forControlEvents: .TouchUpInside)
		backButton.tintColor = UIColor.blackColor()
		backButton.exclusiveTouch = true
		view.addSubview(backButton)
	}

	func back() {
        delegate?.inputTextViewDidReturn(index, text: textView.text)
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
	}

}

extension InputViewController: UITextViewDelegate {

	func textViewDidChange(textView: UITextView) {
//        if textView.text != "" {
//            let quitButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(back))
//            navigationItem.rightBarButtonItem = quitButton
//        } else {
//            let quitButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: #selector(back))
//            navigationItem.rightBarButtonItem = quitButton
//        }
	}

	func textViewDidEndEditing(textView: UITextView) {
		delay(seconds: 1.5) { self.addBackButton() }
	}
}
