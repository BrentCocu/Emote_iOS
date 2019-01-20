//
//  BaseRepository.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BaseRepository {
	
	static let shared = BaseRepository()
	
	private init() { }
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Emote")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
			fatalError("fatal error on loading container \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func populate() {
		EmotionRepository.shared.deleteAll()
		let e1 = EmotionRepository.shared.insert(name: "Angry", color: UIColor(named: "red")!)
		let e2 = EmotionRepository.shared.insert(name: "Happy", color: UIColor(named: "blue")!)
		let _ = EmotionRepository.shared.insert(name: "Anxious", color: UIColor(named: "green")!)
		
		MomentRepository.shared.deleteAll()
		_ = MomentRepository.shared.insert(content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in nisl eleifend, efficitur sapien eget, sollicitudin ex. Donec rhoncus consectetur ligula eget interdum. Nullam nec fermentum neque, ut convallis erat. In egestas ligula blandit dui lacinia vulputate. Praesent eget sem velit. Fusce bibendum porta lectus, quis aliquet felis facilisis ut. Nullam bibendum dictum sapien, id volutpat ipsum varius nec. Donec volutpat massa quis venenatis bibendum.", date: Date(), emotion: e1!)
		_ = MomentRepository.shared.insert(content: "Sed tristique diam dui, sit amet pellentesque nibh gravida id. Nunc dictum vehicula nisl sed scelerisque. Sed fringilla maximus neque, vel lobortis metus porttitor id. Praesent mauris est, aliquet ac ante quis, sodales interdum lorem. Sed sapien ante, vulputate id suscipit ac, feugiat ac orci. Quisque eu elit maximus sem ornare viverra vel sodales nibh. Donec at velit tortor.", date: Date(), emotion: e2!)
	}
}
