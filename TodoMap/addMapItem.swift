//
//  addMapItem.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/20.
//

import Foundation
import RealmSwift

class addMapItem: Object {
    
    @objc dynamic var id : String = NSUUID().uuidString
    @Persisted var title: String = ""
    @Persisted var posLatitude: Double = 0.0 // Double型に変更
    @Persisted var posLongitude: Double = 0.0 // Double型に変更
    @Persisted var maptitle: String = ""
    @Persisted var date: String = ""
    @Persisted var memo: String = ""
    @Persisted var time: Date
  
}
