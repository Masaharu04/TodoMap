//
//  upDateViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/24.
//

import UIKit
import RealmSwift

class upDateViewController: UIViewController {
    
   
       
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ritememo: UITextView!
    @IBOutlet var button: UIButton!

    var item: addMapItem?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        try! realm.write{
            //item?.title = "yuruyuru"
        }

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
