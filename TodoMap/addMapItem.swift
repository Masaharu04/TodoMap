//
//  addMapItem.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/20.
//

import Foundation
import RealmSwift

class addMapItem: Object {
    @Persisted var title: String = ""
    @Persisted var posLatitude = ""
    @Persisted var maptitle: String = ""
    @Persisted var date: String = ""
    @Persisted var memo: String = ""
    @Persisted var id: Int 
    
}
