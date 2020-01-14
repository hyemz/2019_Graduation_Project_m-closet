//
//  GalleryGL+CoreDataProperties.swift
//  
//
//  Created by You Know I Mean on 2019/12/08.
//
//

import Foundation
import CoreData


extension GalleryGL {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GalleryGL> {
        return NSFetchRequest<GalleryGL>(entityName: "Gallery")
    }

    @NSManaged public var category: String?
    @NSManaged public var image: Data?
    @NSManaged public var regdate: String?
    @NSManaged public var title: String?
    @NSManaged public var memo: String?
    @NSManaged public var count: String?

}
