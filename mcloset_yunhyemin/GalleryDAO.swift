//
//  GalleryDAO.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 19/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit
import CoreData


class GalleryDAO {
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func fetch() -> [AddData] {
        var Addlist = [AddData]()
        
        // 요청 객체 생성
        let fetchRequest: NSFetchRequest<GalleryGL> = GalleryGL.fetchRequest()
        
        // 최신 글 순으로 정렬하도록
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        do {
            let resultset = try self.context.fetch(fetchRequest)
            
            // 읽어온 결과 집합을 순화하면서 [AddData] 타입으로 변환
            for record in resultset {
                // AddData 객체 생성
                let data = AddData()
                
                // GalleryGL 프로퍼티 값을 AddData의 프로퍼티로 복사
                data.title = record.title
                data.category = record.category
                data.regdate = record.regdate
                data.objectID = record.objectID
                
                // 이미지가 있을 때 복사
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                
                // AddData 객체를 Addlist 배열에 추가
                Addlist.append(data)
            }
        } catch let e as NSError {
            NSLog("An error has occurred: %s", e.localizedDescription)
        }
        return Addlist
    }
    
    func insert(_ data: AddData) {
        // 관리 객체 인스턴스 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Gallery", into: self.context) as! GalleryGL
        
        // AddData로부터 값을 복사
        object.title = data.title
        object.category = data.category
        object.regdate = data.regdate
        
        if let image = data.image {
            object.image = image.pngData()
        }
        
        // 영구 저장소에 변경 사항을 반영
        do {
            try self.context.save()
        } catch let e as NSError {
            NSLog("An error has occurred: %s", e.localizedDescription)
        }
    }
    
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        // 삭제할 객체를 찾고 컨텍스트에서 삭제
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        
        // 영구 저장소에 변경 사항을 반영
        do {
            try self.context.save()
            return true
        } catch let e as NSError {
            NSLog("An error has occurred: %s", e.localizedDescription)
            return false
        }
    }

}


    

    


