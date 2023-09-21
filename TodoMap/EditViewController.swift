//
//  EditViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//

import UIKit
import RealmSwift
class EditViewController: UIViewController {
    
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ritememo: UITextView!
    
    let realm = try! Realm()
       
       override func viewDidLoad() {
           super.viewDidLoad()

           // DatePickerの設定
           datePicker.datePickerMode = .dateAndTime // 日付と時刻の選択を可能にします
           datePicker.calendar = Calendar.current // 現在のカレンダーを使用します
           datePicker.locale = Locale(identifier: "ja_JP") // ロケールを日本に設定します（日本のカレンダー形式に合わせます）
       }
    
    @IBAction func back() {
        self.dismiss(animated: true)
    }

    @IBAction func save() {
        let item = addMapItem()
        item.title = titleTextField.text ?? ""
       
        
        // UIDatePickerから日付を取得し、Stringに変換
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        item.date = dateFormatter.string(from: datePicker.date)
        
        item.memo = ritememo.text ?? ""
        
        createItem(item: item) // データをRealmに保存
        self.dismiss(animated: true)
    }

    
    func createItem(item: addMapItem) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("データの保存に失敗しました: \(error)")
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

}
