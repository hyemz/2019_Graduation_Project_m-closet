//
//  JoinVC.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 18/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics
import ZImageCropper
import CoreData

class AddData {
    var AddIdx: Int?       // 데이터 식별값
    var title: String?            // 메모 제목
    var category: String?   // 카테고리
    var image: UIImage?    // 이미지
    var regdate: String? // 시간
    var memo: String? // 메모
    var count: Int?
    
    var objectID: NSManagedObjectID?
}

class gallery {
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func fetch(keyword : String? = nil) -> [AddData] {
        var Addlist = [AddData]()
        let fetchRequest:NSFetchRequest<GalleryGL> = GalleryGL.fetchRequest()
        if let t = keyword, t.isEmpty == false {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", t)
        }
        
        let regDateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regDateDesc]
        do {
            let resultSet = try self.context.fetch(fetchRequest)
            for record in resultSet {
                let data = AddData()
                data.title = record.title
                data.category = record.category
                data.regdate = record.regdate
                data.memo = record.memo
                data.objectID = record.objectID
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                Addlist.append(data)
            }
        }catch let e as NSError {
            print("\(e.localizedDescription)")
        }
        return Addlist
    }
    func fetches(keyword : String? = nil) -> [AddData] {
        var Addlist = [AddData]()
        let fetchRequest:NSFetchRequest<GalleryGL> = GalleryGL.fetchRequest()
        if let t = keyword, t.isEmpty == false {
            fetchRequest.predicate = NSPredicate(format: "category CONTAINS[cd] %@", t)
        }
        
        let regDateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regDateDesc]
        do {
            let resultSet = try self.context.fetch(fetchRequest)
            for record in resultSet {
                let data = AddData()
                data.title = record.title
                data.category = record.category
                data.regdate = record.regdate
                data.memo = record.memo
                data.objectID = record.objectID
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                Addlist.append(data)
            }
        }catch let e as NSError {
            print("\(e.localizedDescription)")
        }
        return Addlist
    }
    
    func insert(_ data:AddData){
        let object = NSEntityDescription.insertNewObject(forEntityName: "Gallery", into:self.context) as! GalleryGL
        object.title = data.title
        object.category = data.category
        object.memo = data.memo
        object.regdate = data.regdate
        if let image = data.image {
            object.image = image.pngData()
        }
        do {
            try self.context.save()
        } catch let e as NSError{
            print("\(e.localizedDescription)")
        }
    }
    func delete(_ objectID: NSManagedObjectID) -> Bool{
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        do {
            try self.context.save()
            return true
        } catch let e as NSError{
            print("\(e.localizedDescription)")
            return false
        }
    }
}

class JoinVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    // let realm = try! Realm()
    //var addList : Results<AddData>?
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var profile: UIImageView!
    var fieldName: UITextField!
    var fieldDate: UITextField!
    var fieldmemo: UITextField!
    
    @IBOutlet weak var categories: UITextField!
    var categorylist = ["아우터",
                        "상의",
                        "셔츠/블라우스",
                        "팬츠",
                        "스커트/원피스", "기타"]
    
    override func viewDidLoad() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
        
        let picker = UIPickerView()
        picker.delegate = self
        // 텍스트 필드 입력 방식을 키보드 대신 피커 뷰로 설정
        self.categories.inputView = picker
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width-20, height: 37)
        
        switch indexPath.row {
        case 0 :
            self.fieldName = UITextField(frame: tfFrame)
            self.fieldName.placeholder = "이름을 설정해주세요."
            self.fieldName.borderStyle = .none
            self.fieldName.autocapitalizationType = .none
            self.fieldName.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldName)
        case 1 :
            self.fieldDate = UITextField(frame: tfFrame)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.fieldDate?.text = formatter.string(from:Date())
            self.fieldDate.borderStyle = .none
            self.fieldDate.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldDate)
        case 2:
            self.fieldmemo = UITextField(frame: tfFrame)
            self.fieldmemo.placeholder = "메모"
            self.fieldmemo.borderStyle = .none
            self.fieldmemo.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldmemo)
        default :
            ()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @objc func tappedProfile(_ sender: Any) {
        
        // 액션 시트
        let msg = "이미지를 읽어올 곳을 선택하세요"
        let sheet = UIAlertController(title: msg, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        sheet.addAction(UIAlertAction(title: "저장된 앨범", style: .default) { (_) in
            selectLibrary(src: .savedPhotosAlbum)
        })
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { (_) in
            selectLibrary(src: .photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
            selectLibrary(src: .camera)
        })
        
        self.present(sheet, animated: false)
        
        // 이미지 피커창 호출
        func selectLibrary(src: UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(src) {
                let picker = UIImagePickerController()
                picker.sourceType = src
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: false)
            }
            else{
                print("지원하지 않는 형식 입니다.")
            }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.editedImage] as? UIImage {
            self.profile.image = img
            print(info)
            
        }
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않은경우 경고
        guard self.fieldName.text!.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "이름을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        guard self.categories.text!.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "카테고리를 선택해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        // AddData 객체를 생성하고 데이터를 담음
        //let data = AddData()
        
        
        let data = AddData()
        
        data.title = self.fieldName.text // 제목
        data.category = self.categories.text  // 내용
        data.image = croppedImage     // 이미지
        data.regdate = self.fieldDate.text
        data.memo = self.fieldmemo.text// 작성 시각
        data.count = 1
        
        // addList = realm.objects(AddData.self)
        
        
        // 앱 델리개이트 객체를 읽어온 다음 memolist 배열에 MemoData 객체를 추가
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.Addlist.append(data)*/
        let gly = gallery()
        gly.insert(data)
        
        // 작성폼 화면을 종료하고 이전 화면으로 돌아감
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        
        UIView.animate(withDuration: 0.3) {
            bar?.alpha = bar?.alpha == 0 ? 1 : 0
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 컴포넌트가 가질 목록의 길이
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categorylist.count
    }
    
    // 컴포넌트의 목록 각 행에 출력될 내용
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categorylist[row]
    }
    
    // 컴포넌트의 행을 선택했을 때 실행할 액션
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categories = self.categorylist[row] // 선택된 계정
        self.categories.text = categories
        
        // 입력 뷰 닫기
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var imageView: ZImageCropperView!
    var croppedImage: UIImage?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //
    //MARK:- IBAction methods
    //
    
    @IBAction func IBActionCropImage(_ sender: UIButton) {
        croppedImage = imageView.cropImage()
    }
    
    @IBAction func IBActionAI(_ sender: Any) {
        croppedImage = ZImageCropper.cropImage(ofImageView: imageView, withinPoints: [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 100, y: 0),
            CGPoint(x: 100, y: 100),
            CGPoint(x: 0, y: 100)
        ])
    }
    
    @IBAction func IBActionCancelCrop(_ sender: UIButton) {
        imageView.resetCrop()
        croppedImage = self.profile.image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC:NewImageViewController = segue.destination as! NewImageViewController
        
        destinationVC.newImageFile = croppedImage
    }
    
    
}

