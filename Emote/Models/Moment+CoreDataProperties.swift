//
//  Moment+CoreDataProperties.swift
//  Emote
//
//  Created by Brent Cocu on 20/01/2019.
//  Copyright © 2019 Brent Cocu. All rights reserved.
//
//

import Foundation
import CoreData


extension Moment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Moment> {
        return NSFetchRequest<Moment>(entityName: "Moment")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var content: String?
    @NSManaged public var emotion: Emotion?

}
