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
        
        // マップビューのデリゲートを設定
        homeMapView.delegate = self
        
        // ロングプレス（長押し）ジェスチャーを追加
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
               homeMapView.addGestureRecognizer(longPressGesture)
    }
    
    @IBAction func reload() {
        // マップ上の既存のピンをすべて削除
        homeMapView.removeAnnotations(homeMapView.annotations)
        
        // Realmから新しいデータを読み込み
        items = read()
        
        for item in items {
            let mapTitle = item.title
            let posLatitude = item.posLatitude
            let posLongitude = item.posLongitude
            let date = item.date
            
            // ピンをマップに追加
            addPinToMap(latitude: posLatitude, longitude: posLongitude, title: mapTitle, date: date)
        }
    }
    
    func read() -> [addMapItem] {
        return Array(realm.objects(addMapItem.self))
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: homeMapView)
            let coordinate = homeMapView.convert(touchPoint, toCoordinateFrom: homeMapView)
        }
    }
    
    func addPinToMap(latitude: Double, longitude: Double, title: String, date: String) {
        // 座標を作成
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // ピンを作成
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = date // mapTitleを設定
        annotation.subtitle = title // dateを設定
        
        // マップビューにピンを追加
        homeMapView.addAnnotation(annotation)
    }
    //ピンのアラート
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // ピンが選択された時の処理
        let alertController = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        
        // 編集オプションを追加
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] (_) in
            // ピンの編集画面に遷移するなどの処理を実装
            // 編集が完了したらRealmのデータも更新することを忘れないでください
        }
        
        // 削除オプションを追加
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (_) in
            if let selectedAnnotation = view.annotation as? MKPointAnnotation {
                // マップからピンを削除
                mapView.removeAnnotation(selectedAnnotation)
                
                // Realmからデータを削除
                if let itemToDelete = self?.items.first(where: { $0.title == selectedAnnotation.subtitle }) {
                    do {
                        try self?.realm.write {
                            self?.realm.delete(itemToDelete)
                        }
                    } catch {
                        print("Error deleting item from Realm: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        // キャンセルオプションを追加
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil // ユーザーの現在位置のピンはカスタマイズしない
        }
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "customPin") as? MKMarkerAnnotationView {
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
            annotationView.canShowCallout = true // ピンをタップしたときにCalloutを表示
            
            
            return annotationView
        }
    }
    

    
}
