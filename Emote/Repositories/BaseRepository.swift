//
//  BaseRepository.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import CoreData

protocol BaseRepository {
	
	var persistentContainer: NSPersistentContainer { get }
	
	func saveContext ()	
}

extension BaseRepository {
	
	var persistentContainer: NSPersistentContainer {
		let container = NSPersistentContainer(name: "Emote")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("fatal error on loading container \(error), \(error.userInfo)")
			}
		})
		return container
	}
	
	func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
				return
			} catch {
				let nserror = error as NSError
				fatalError("fatal error on saving context \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
