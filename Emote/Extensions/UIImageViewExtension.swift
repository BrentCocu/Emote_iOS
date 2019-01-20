//
//  UIImageViewExtension.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import UIKit

// SOURCE: https://stackoverflow.com/questions/31803157/how-can-i-color-a-uiimage-in-swift
extension UIImageView {
	func setImageColor(color: UIColor) {
		let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
		self.image = templateImage
		self.tintColor = color
	}
}
