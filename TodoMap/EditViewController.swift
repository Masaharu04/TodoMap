//
//  EditViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//

import UIKit
import RealmSwift
import CoreLocation



class EditViewController: UIViewController, CatchProtocol {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ritememo: UITextView!
    
    @IBOutlet var button: UIButton!
    
    @objc dynamic var id : Int = 0
    
    var selectedPlaceName: String?
    var selectedPlaceCoordinate: CLLocationCoordinate2D?
    
    let realm = try! Realm()
       
    
   override func viewDidLoad() {
       super.viewDidLoad()

       button.setTitle("行き先を追加しよう！", for: .normal)
       // DatePickerの設定
       
       
       datePicker.locale = Locale(identifier: "ja_JP") // ロケールを日本に設定します（日本のカレンダー形式に合わせます）
   }

    @IBAction func back() {
        self.dismiss(animated: true)
    }

    @IBAction func save() {
          
           let item = addMapItem()
           item.title = titleTextField.text ?? ""
          
           item.maptitle = selectedPlaceName ?? ""
           if let coordinate = selectedPlaceCoordinate {
               // 緯度と経度を取得して保存
               item.posLatitude = coordinate.latitude
               item.posLongitude = coordinate.longitude
           }
           
           // UIDatePickerから日付を取得し、Stringに変換
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy年MM月dd日"
            item.date = dateFormatter.string(from: datePicker.date)
            item.time = datePicker.date
            item.memo = ritememo.text ?? ""
           
           createItem(item: item) // データをRealmに保存
        self.presentingViewController?.beginAppearanceTransition(true, animated: true)
           self.dismiss(animated: true)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
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
    
    // 画面遷移する時に渡すデータ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! addMapViewController
        
        // 遷移先からデータをもらう関数の集合体
        destinationVC.delegate = self
    }
    
    // 画面遷移先からデータをもらう関数
    func catchData(
        selectedPlaceName: String?,
        selectedPlaceCoordinate: CLLocationCoordinate2D?
    ){
        self.selectedPlaceName = selectedPlaceName
        self.selectedPlaceCoordinate = selectedPlaceCoordinate
        
        //ボタンに場所名を表示
        button.setTitle(selectedPlaceName, for: .normal)
        
        print(selectedPlaceName ?? "")
        print("lat" + String(selectedPlaceCoordinate?.latitude ?? 0) + "lon" + String(selectedPlaceCoordinate?.longitude ?? 0))
        
        
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
