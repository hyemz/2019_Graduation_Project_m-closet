//
//  SideBarVC.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 18/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit
import CoreData

class SideBarVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let nameLabel = UILabel() // 알림
    let noticeLabel = UILabel() // 설명
    let noticeImage = UIImageView() // 프로필 이미지
    // 목록 데이터
    var test = "0"
    let titles = ["아우터", "상의", "셔츠/블라우스", "팬츠", "스커트/원피스", "기타", "알림 설정"]
    //  아이콘
    let icons = [UIImage(named: "ed_outer"),
                 UIImage(named: "ed_top"),
                 UIImage(named: "ed_shirts"),
                 UIImage(named: "ed_pants"),
                 UIImage(named: "ed_skirt"),
                 UIImage(named: "ed_etc"),
                 UIImage(named: "ed_noti")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let revealVC = self.revealViewController() {
            // 바 버튼 아이템 객체를 정의
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu") // 버튼 이미지 설정
            btn.target = revealVC // 버튼 클릭시 호출할 메서드가 정의된 객체
            btn.action = #selector(revealVC.revealToggle(_:)) // 버튼 클릭시 호출
            // 바 버튼 등록
            self.navigationItem.leftBarButtonItem = btn
            
            // 제스처 객체를 뷰에 추가
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        // 테이블 뷰의 헤더 역할을 할 뷰
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .white
        self.tableView.tableHeaderView = headerView
        //headerView.isHidden = true
        // 이름 레이블
        self.nameLabel.frame = CGRect(x: 80, y: 20, width: 100, height: 30)
        self.nameLabel.text = "알림"
        self.nameLabel.textColor = .blue
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.nameLabel.backgroundColor = .clear
        
        headerView.addSubview(self.nameLabel)
        
        // 알림 정보
        self.noticeLabel.frame = CGRect(x: 80, y: 35, width: 130, height: 30)
        self.noticeLabel.text = "옷장을 정리하세요."
        self.noticeLabel.font = UIFont.systemFont(ofSize: 11)
        self.noticeLabel.backgroundColor = .clear
        
        headerView.addSubview(self.noticeLabel)
        
        // 알림 사진
        let defaultNotice = UIImage(named: "ed_warning")
        self.noticeImage.image = defaultNotice
        self.noticeImage.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        
        // 알림 이미지 둥글게 처리
        /* self.noticeImage.layer.cornerRadius = self.noticeImage.frame.width / 2 // 반원 형태*/
        self.noticeImage.layer.borderWidth = 0 // 테두리 두께
        self.noticeImage.layer.masksToBounds = true // 마스크 효과
        
        view.addSubview(self.noticeImage)
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell" // 테이블 셀 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 테이블과 이미지를 대입
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row == 0 {
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
        } else if indexPath.row == 1{
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
        } else if indexPath.row == 2{
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
            
        } else if indexPath.row == 3{
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
        } else if indexPath.row == 4{
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
        }else if indexPath.row == 5{
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
        }
        else if indexPath.row == 6{
            appDelegate.test = titles[indexPath.row]
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "NotiVC") as! NotiVC
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv, animated: true)
            self.revealViewController()?.revealToggle(self)
        }
    }
    
}
