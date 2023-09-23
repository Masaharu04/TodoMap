//
//  ViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//
import UIKit
import MapKit
import RealmSwift

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var homeMapView: MKMapView!
    @IBOutlet var testLabel: UILabel!
    
    var labelText = ""
    
    let realm = try! Realm()
    var items: [addMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = read()
        
        for item in items {
            let mapTitle = item.maptitle
            let posCoordinates = item.posLatitude.components(separatedBy: ",") // 緯度と経度を分割
            
            if posCoordinates.count == 2, let posLatitude = Double(posCoordinates[0]), let posLongitude = Double(posCoordinates[1]) {
                // タイトルを取得
                let title = item.title
                
                // ピンをマップに追加
                addPinToMap(latitude: posLatitude, longitude: posLongitude, title: title)
                
                // ラベルに表示
                testLabel.text = mapTitle
            }
        }
    }
    
    @IBAction func reload() {
        // Realmから新しいデータを読み込み
        items = read()
        
        for item in items {
            print("Reload function started")
            let mapTitle = item.maptitle
            let posCoordinates = item.posLatitude.components(separatedBy: ",") // 緯度と経度を分割
            print(posCoordinates)
            var title = item.title
            
            //addPinToMap(latitude: 34.7022985, longitude: 135.4953492, title: title)
           // addPinToMap(latitude: 35.6901339473, longitude: 139.6991500282, title: title)
            // 緯度と経度をDouble型に変換
            if posCoordinates.count != 2 { return }
            guard let posLatitude  = Double(posCoordinates[0]) else { return }
            guard let posLongitude = Double(posCoordinates[1]) else { return }
            print("posLongitude was not unwraped")
            title = item.title
            addPinToMap(latitude: posLatitude, longitude: posLongitude, title: title)
            testLabel.text = mapTitle
        }
    }
    func read() -> [addMapItem] {
        return Array(realm.objects(addMapItem.self))
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func addPinToMap(latitude: Double, longitude: Double, title: String) {
        // 座標を作成
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // ピンを作成
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        
        // マップビューにピンを追加
        homeMapView.addAnnotation(annotation)
        

    }
    
}
