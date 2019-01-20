//
//  CoreDataManager.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class EmotionRepository {
	
	static let shared = EmotionRepository()
	
	private init() {
		deleteAll()
		let _ = insert(name: "Angry", color: UIColor(named: "red")!)
		_ = insert(name: "Happy", color: UIColor(named: "blue")!)
		_ = insert(name: "Anxious", color: UIColor(named: "green")!)
	}
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Emote")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("fatal error on loading container \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
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
	
	func getAll() -> [Emotion]? {
		let context = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Emotion")
		
		do {
			let emotions = try context.fetch(fetchRequest)
			return emotions as? [Emotion]
		} catch let error as NSError {
			print("error on getAll \(error), \(error.userInfo)")
			return nil
		}
	}
	
	func insert(name: String, color: UIColor) -> Emotion? {
		let context = persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Emotion", in: context)!
		let emotion = NSManagedObject(entity: entity, insertInto: context)
		
		emotion.setValue(name, forKeyPath: "name")
		emotion.setValue(color, forKeyPath: "color")
		
		do {
			try context.save()
			return emotion as? Emotion
		} catch let error as NSError {
			print("error on insert \(error), \(error.userInfo)")
			return nil
		}
	}
	
	func update(name: String, color: UIColor, emotion: Emotion) {
		let context = persistentContainer.viewContext
		
		emotion.setValue(name, forKey: "name")
		emotion.setValue(color, forKey: "color")
		
		do {
			try context.save()
		} catch let error as NSError  {
			print("error on update \(error), \(error.userInfo)")
		}
	}
	
	func delete(emotion: Emotion) {
		let context = persistentContainer.viewContext
		
		context.delete(emotion)
		
		do {
			try context.save()
		} catch let error as NSError  {
			print("error on delete \(error), \(error.userInfo)")
		}
	}
	
	private func deleteAll() {
		let context = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Emotion")
		
		do {
			let emotions = try context.fetch(fetchRequest)
			for emotion in emotions {
				context.delete(emotion)
			}
			try context.save()
		} catch let error as NSError {
			print("error on deleteAll \(error), \(error.userInfo)")
		}
	}
}
