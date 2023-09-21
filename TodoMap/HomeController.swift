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
    
    let realm = try! Realm()
    var items: [addMapItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = read()
       
        if let firstItem = items.first {
               let mapTitle = firstItem.maptitle
               testLabel.text = mapTitle
            
                print(firstItem)
           }
        // 指定された座標を作成
        let coordinate = CLLocationCoordinate2D(latitude: 34.7024, longitude: 135.4959)
        
        
   /*
        // アノテーションを作成
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "ラーメンを食べにいく"
        annotation.subtitle = "10月８日"
        
        // マップビューにアノテーションを追加
        homeMapView.addAnnotation(annotation)
      */
        // マップビューの表示領域を指定された座標にズーム
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        homeMapView.setRegion(region, animated: true)
    }
    
    func read() -> [addMapItem]{
        return Array(realm.objects(addMapItem.self))
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
     
    }

}

