//
//  EditMomentController.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import UIKit

class EditMomentController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
	
	@IBOutlet weak var name: UITextField!
	@IBOutlet var content: UITextView!
	@IBOutlet weak var deleteButton: UIButton!
	@IBOutlet weak var color: UIControl!
	@IBOutlet weak var scrollView: UIScrollView!
	
	var moment: Moment?
	var emotion: Emotion?
	var _name: String?
	var _content: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		color.backgroundColor = emotion?.color
		content.text = _content
		name.text = emotion?.name
		deleteButton.isHidden = (moment == nil)
		
		// hide keyboard on 'done'
		name.delegate = self
		content.delegate = self
	}
	
	private func updateComponents() {
		color.backgroundColor = emotion?.color
		name.text = emotion?.name
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if(text == "\n") {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
	
	@IBAction func showEmotionList(_ sender: UIView) {
		let _emotions = EmotionRepository.shared.getAll()
		let emotions = _emotions?.map({(emotion) -> String in return emotion.name!})
		let controller = ArrayChoiceTableViewController(emotions ?? []) { (result) in
			let index = _emotions?.firstIndex(where: { (emotion) -> Bool in
				emotion.name == result
			})
			self.emotion = _emotions![index!]
			self.updateComponents()
		}
		controller.preferredContentSize = CGSize(width: 300, height: 200)
		showPopup(controller, sourceView: sender)
	}
	
	private func showPopup(_ controller: UIViewController, sourceView: UIView) {
		controller.modalPresentationStyle = .popover
		controller.preferredContentSize = CGSize(width: 300, height: 200)
		let presentationController = controller.presentationController as! UIPopoverPresentationController
		presentationController.sourceView = sourceView
		presentationController.sourceRect = sourceView.bounds
		presentationController.permittedArrowDirections = [.down, .up]
		self.present(controller, animated: true)
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		let scrollPoint : CGPoint = CGPoint.init(x:0, y:textView.frame.origin.y + 16)
		self.scrollView.setContentOffset(scrollPoint, animated: true)
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		self.scrollView.setContentOffset(CGPoint.zero, animated: true)
	}
}
