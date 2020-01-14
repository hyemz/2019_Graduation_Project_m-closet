//
//  ListVC.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 18/06/2019.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import UIKit
import CoreData

class ListVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //let join  = JoinVC()
    let gly = gallery()
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = "검색어를 입력하세요."
        self.navigationItem.title = appDelegate.test
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if appDelegate.test == "전체 게시물"
        {
            self.appDelegate.Addlist = gly.fetch()
        } else {
            self.appDelegate.Addlist = gly.fetches(keyword:appDelegate.test)
        }
        //}
        // 테이블 데이터 리로드
        //join.addList = join.realm.objects(AddData.self)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    // 테이블 뷰의 셀 개수를 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.Addlist.count
    }
    // 개별 행을 구성하는 메서드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // memolist 배열에서 주어진 행에 맞는 데이터를 꺼냄
        let row = self.appDelegate.Addlist[indexPath.row]
        //let row = self.join.addList?[indexPath.row]
        // 이미지 속성이 비어 있고 없고에 따라 프로토타입 셀 식별자를 변경
        let cellId = row.image == nil ? "ListCell" : "AddlistCell"
        
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달 받음
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListCell
        
        // 내용 구성
        cell.subject?.text = row.title
        cell.category?.text = row.category
        cell.img?.image = row.image
        cell.regdate?.text = row.regdate
        
        // Date 타입의 날짜를 포멧에 맞게 변경
        /*let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         cell.regdate?.text = formatter.string(from: row.regdate!)*/
        
        return cell
    }
    
    // 테이블 행을 선택하면 호출되는 메서드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.Addlist[indexPath.row]
        //let row = self.join.addList![indexPath.row]
        // 상세 화면 인스턴스 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        // 값을 전달한 다음 상세 화면으로 이동
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        let data = self.appDelegate.Addlist[indexPath.row]
        let gly = gallery()
        if gly.delete(data.objectID!){
            self.appDelegate.Addlist.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with:.left)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension ListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text
        let gly = gallery()
        self.appDelegate.Addlist = gly.fetch(keyword:keyword)
        if(["아우터", "상의", "셔츠/블라우스", "팬츠", "스커트/원피스", "기타", ].contains(keyword)){
            self.appDelegate.Addlist = gly.fetches(keyword: keyword)
        } else if ["전체", "all"].contains(keyword) {
            self.appDelegate.Addlist = gly.fetch()
            appDelegate.test = "전체 게시물"
            self.navigationItem.title = appDelegate.test
        }
        self.tableView.reloadData()
    }
}
