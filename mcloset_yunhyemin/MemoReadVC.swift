//
//  MemoReadVC.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 19/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit
import CoreData
//import RealmSwift

class MemoReadVC: UIViewController {
    
    //let object = NSEntityDescription.insertNewObject(forEntityName: "Gallery", into:gallery().context) as! GalleryGL
    
    // let realm = try! Realm()
    //var galleryArray : Results<Gallery>?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var steppertext: UILabel!
    var param: AddData?
    override func viewDidLoad() {
        
        
        self.titles.text = param?.title
        self.category.text = param?.category
        self.imageView.image = param?.image
        self.time.text = param?.regdate
        self.memo.text = param?.memo
        // 날짜 포멧 변환
        /* let formatter = DateFormatter()
         formatter.dateFormat = "dd일 HH:mm분에 작성됨"
         let dateString = param?.regdate
         */
        /*self.paramInterval.addTarget(self, action: #selector(stepper(_:)), for: .valueChanged)*/
        // 내비게이션 타이틀에 날짜 표시
        self.navigationItem.title = titles.text
    }
    
    
    @IBAction func stepper(_ sender: UIStepper) {
        self.memo.text = "\(Int(sender.value))번 입었습니다."
    }
    /* func loadData () {
     galleryArray = realm.objects(Gallery.self)
     }*/
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
