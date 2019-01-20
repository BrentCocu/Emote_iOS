//
//  EditEmotionController.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import UIKit
import MKColorPicker

class EditEmotionController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var color: UIView!
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var deleteButton: UIButton!
	
	var emotion: Emotion?
	var _name: String?
	var _color: UIColor?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		color.backgroundColor = _color
		name.text = _name
		deleteButton.isHidden = (emotion == nil)
		
		// hide keyboard on 'done'
		name.delegate = self
	}
	
	@IBAction func showColorPicker(_ sender: Any) {
		let MKColorPicker = ColorPickerViewController()
		MKColorPicker.selectedColor = { color in
			self.color.backgroundColor = color
		}
		
		if let popoverController = MKColorPicker.popoverPresentationController{
			popoverController.delegate = MKColorPicker
			popoverController.permittedArrowDirections = .any
			popoverController.sourceView = sender as? UIView
			popoverController.sourceRect = ((sender as? UIView)?.bounds)!
		}
		
		MKColorPicker.allColors = UIColor.getMaterialColors()
		
		self.present(MKColorPicker, animated: true, completion: nil)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
