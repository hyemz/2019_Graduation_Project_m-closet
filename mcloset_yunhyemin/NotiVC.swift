//
//  NotiVC.swift
//  mcloset_yunhyemin
//
//  Created by You Know I Mean on 2019/12/08.
//  Copyright © 2019 You Know I Mean. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NotiVC: UIViewController {
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    //@IBOutlet weak var timmerPicker: UIDatePicker!
    @IBOutlet weak var timmerPicker: UIDatePicker!
    // 일정 등록 클릭 시
    @IBAction func showNotificationAction(_ sender: Any) {
        // picker.data 포멧 변경
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko")
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .medium
        let date = dateformatter.string(from: timmerPicker.date)
        print("date= \(date)")
        appDelegate?.showEduNotification(date: timmerPicker.date)
        let alert = UIAlertController(title: "일정이 등록되었습니다", message: "\(date)에 알림이 울립니다. ", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : nil)
        
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
        
    }
    
    // 테스트 버튼 클릭 시
    @IBAction func testNoti(_ sender: UIButton) {
        /*let content = UNMutableNotificationContent()
         content.title = "테스트 알립입니다"
         content.subtitle = "옷장을 정리할 시간입니다."
         content.body = "어플리케이션을 확인해주세요"
         content.badge = 1*/
        
        for index in 1...3 {
            
            //Setting content of the notification
            let content = UNMutableNotificationContent()
            content.title = "테스트 알림입니다"
            content.subtitle = "옷장을 정리할 시간입니다."
            content.body = "어플리케이션을 확인해주세요"
            content.summaryArgument = "Alan Walker"
            content.summaryArgumentCount = 40
            
            //Setting time for notification trigger
            //1. Use UNCalendarNotificationTrigger
            let date = Date(timeIntervalSinceNow: 70)
            let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            var dateset = DateComponents()
            dateset.year = 2020
            dateset.month = 3
            dateset.day = 1
            dateset.hour = 9
            dateset.minute = 0
            dateset.second = 0
            
            let calendartrigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: true)
            
            
            //2. Use TimeIntervalNotificationTrigger
            let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            
            //Adding Request
            // MARK: - identifier가 다 달라야만 Notification Grouping이 됩니닷..!!
            let request = UNNotificationRequest(identifier: "\(index)timerdone", content: content, trigger: TimeIntervalTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (didAllow, error) in
            
        })
        UNUserNotificationCenter.current().delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NotiVC : UNUserNotificationCenterDelegate{
    //To display notifications when app is running  inforeground
    
    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해줍니다.
    //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
    }
    
}


