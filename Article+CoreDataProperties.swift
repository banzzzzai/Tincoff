//
//  Article+CoreDataProperties.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var desc: String?
    @NSManaged public var publishingTime: String
    @NSManaged public var url: String
    @NSManaged public var title: String
    @NSManaged public var imageData: Data
    @NSManaged public var viewsCount: Int64

}

extension Article : Identifiable {

}
