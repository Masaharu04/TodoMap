//
//  upDateViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/24.
//

import UIKit
import RealmSwift
import MapKit

class upDateViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ritememo: UITextView!
    @IBOutlet var button: UIButton!

    var item: addMapItem?
    
    @objc dynamic var id : Int = 0
    

    var selectedPlaceName: String?
    var selectedPlaceCoordinate: CLLocationCoordinate2D?
    
    let realm = try! Realm()
       
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      

       //初期値の設定
        titleTextField.text = item?.title
        ritememo.text = item?.memo
     
        if let date = item?.time {
                  datePicker.date = date
              }
  
        
    }
    
    @IBAction func back() {
        self.dismiss(animated: true)
    }
    
    @IBAction func save() {
       /*
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
           dateFormatter.dateFormat = "yyyy-MM-dd"
            item.date = dateFormatter.string(from: datePicker.date)
            item.time = datePicker.date
            item.memo = ritememo.text ?? ""
           
           createItem(item: item) // データをRealmに保存
        self.presentingViewController?.beginAppearanceTransition(true, animated: true)
           self.dismiss(animated: true)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        */
        try! realm.write{
           // item?.title = "yuruyuru"
            item?.title = titleTextField.text ?? ""
            // UIDatePickerから日付を取得し、Stringに変換
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年MM月dd日"
            item?.date = dateFormatter.string(from: datePicker.date)
            item?.time = datePicker.date
            item?.memo = ritememo.text ?? ""
            
        }

        self.dismiss(animated: true)
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
