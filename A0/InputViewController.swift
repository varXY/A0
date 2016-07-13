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
			case 0: leftTitle = "GOALS"
            case 1: leftTitle = "RESULTS"
			case 2: leftTitle = "CONCLUSION"
			default: break
			}
		}
	}

	var oldText = ""
	var leftTitle = ""
	var newLimit = 0
	var titleLabel: UILabel!
	var textView: UITextView!

	var allowInput = true

	let elementAlpha: CGFloat = 0.6

	weak var delegate: InputViewControllerDelegate?

	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.whiteColor()

		titleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth - 60, 60))
		titleLabel.backgroundColor = UIColor.clearColor()
		titleLabel.textColor = UIColor.blackColor()
		titleLabel.alpha = elementAlpha
		titleLabel.textAlignment = .Left
		titleLabel.font = UIFont.boldSystemFontOfSize(28)
		titleLabel.text = leftTitle
		view.addSubview(titleLabel)
        
        let doneButton = UIButton(type: .System)
        doneButton.frame = CGRectMake(ScreenWidth - 50, 10, 40, 40)
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: #selector(doneEditing), forControlEvents: .TouchUpInside)
        doneButton.exclusiveTouch = true
        view.addSubview(doneButton)
        

		let factor: CGFloat = ScreenHeight != 480 ? 0.38 : 0.3
		textView = UITextView(frame: CGRectMake(0, 60, ScreenWidth, ScreenHeight * factor))
		textView.backgroundColor = UIColor.clearColor()
		textView.tintColor = UIColor.blackColor()
		textView.textColor = UIColor.blackColor()
		textView.font = UIFont.systemFontOfSize(25)
		textView.textAlignment = .Center
		textView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
		textView.delegate = self
		view.addSubview(textView)

	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		textView.text = oldText
		if ScreenWidth != 320 { textView.becomeFirstResponder() }
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		if ScreenWidth == 320 { textView.becomeFirstResponder() }
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
        dismissViewControllerAnimated(true, completion: nil)
		
	}

}

extension InputViewController: UITextViewDelegate {

	func textViewDidChange(textView: UITextView) {

	}

	func textViewDidEndEditing(textView: UITextView) {
		delay(seconds: 1.5) { self.addBackButton() }
	}
}

extension InputViewController: UIViewControllerTransitioningDelegate {

	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return BounceAnimationController()
	}

	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return FadeOutAnimationController()
	}
}