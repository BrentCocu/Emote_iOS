//
//  UIColorExtension.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	
	static func getMaterialColors() -> [UIColor] {
		var colors = [UIColor]()
		colors.append(UIColor(named: "amber")!)
		colors.append(UIColor(named: "blue_grey")!)
		colors.append(UIColor(named: "blue")!)
		colors.append(UIColor(named: "brown")!)
		colors.append(UIColor(named: "cyan")!)
		colors.append(UIColor(named: "deep_orange")!)
		colors.append(UIColor(named: "deep_purple")!)
		colors.append(UIColor(named: "green")!)
		colors.append(UIColor(named: "grey")!)
		colors.append(UIColor(named: "indigo")!)
		colors.append(UIColor(named: "light_blue")!)
		colors.append(UIColor(named: "light_green")!)
		colors.append(UIColor(named: "lime")!)
		colors.append(UIColor(named: "orange")!)
		colors.append(UIColor(named: "pink")!)
		colors.append(UIColor(named: "purple")!)
		colors.append(UIColor(named: "red")!)
		colors.append(UIColor(named: "teal")!)
		colors.append(UIColor(named: "yellow")!)
		return colors
	}
}
