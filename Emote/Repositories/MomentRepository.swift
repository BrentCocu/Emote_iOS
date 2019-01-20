//
//  MomentRepository.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//

import Foundation
import CoreData

class MomentRepository {
	
	static let shared = MomentRepository()
	
	var persistentContainer = BaseRepository.shared.persistentContainer
	
	private init() { }
	
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
	
	func getAll() -> [Moment]? {
		let context = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Moment")
		
		do {
			let moments = try context.fetch(fetchRequest)
			return moments as? [Moment]
		} catch let error as NSError {
			print("error on getAll \(error), \(error.userInfo)")
			return nil
		}
	}
	
	func insert(content: String, date: Date, emotion: Emotion) -> Moment? {
		let context = persistentContainer.viewContext
		let entity = NSEntityDescription.entity(forEntityName: "Moment", in: context)!
		let moment = NSManagedObject(entity: entity, insertInto: context)
		
		moment.setValue(content, forKeyPath: "content")
		moment.setValue(date, forKeyPath: "date")
		moment.setValue(emotion, forKey: "emotion")
		
		do {
			try context.save()
			return moment as? Moment
		} catch let error as NSError {
			print("error on insert \(error), \(error.userInfo)")
			return nil
		}
	}
	
	func update(content: String, date: Date, emotion: Emotion, moment: Moment) {
		let context = persistentContainer.viewContext
		
		moment.setValue(content, forKeyPath: "content")
		moment.setValue(date, forKeyPath: "date")
		moment.setValue(emotion, forKey: "emotion")
		
		do {
			try context.save()
		} catch let error as NSError  {
			print("error on update \(error), \(error.userInfo)")
		}
	}
	
	func delete(moment: Moment) {
		let context = persistentContainer.viewContext
		
		context.delete(moment)
		
		do {
			try context.save()
		} catch let error as NSError  {
			print("error on delete \(error), \(error.userInfo)")
		}
	}
	
	func deleteAll() {
		let context = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Moment")
		
		do {
			let moments = try context.fetch(fetchRequest)
			for moment in moments {
				context.delete(moment)
			}
			try context.save()
		} catch let error as NSError {
			print("error on deleteAll \(error), \(error.userInfo)")
		}
	}
}
