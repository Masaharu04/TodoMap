//
//  addMapViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//
//
import UIKit
import MapKit
import RealmSwift


protocol CatchProtocol{
    func catchData(
        selectedPlaceName: String?,
        selectedPlaceCoordinate: CLLocationCoordinate2D?
    )
}

class addMapViewController: UIViewController ,UISearchBarDelegate{
    
    let realm = try! Realm()
    
    @IBOutlet weak var testSearchBar: UISearchBar!
    @IBOutlet weak var testMapView: MKMapView!
    @IBOutlet weak var posNameLabel: UILabel!

    
    
    var selectedPlaceName: String?
    var selectedPlaceCoordinate: CLLocationCoordinate2D?
    
    var testManager:CLLocationManager = CLLocationManager()
    
    /// 前の画面にデータを送る
    var delegate:CatchProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = CLLocationCoordinate2DMake(35.690553, 139.699579)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        
        let region = MKCoordinateRegion(center: center, span: span)
        testMapView.setRegion(region, animated:true)
        
        testSearchBar.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func back(){
        self.dismiss(animated: true)
    }
    
    @IBAction func save() {
       // selectedPlaceName = testSearchBar.text // 場所名データを設定
       // selectedPlaceCoordinate = testMapView.annotations.first?.coordinate // 座標データを設定
        
        // ここで前の画面にデータを渡す
        delegate?.catchData(selectedPlaceName: selectedPlaceName, selectedPlaceCoordinate: selectedPlaceCoordinate)
        // 画面を閉じる
        self.dismiss(animated: true)
    }
      

    func removeAnnotations() {
        let annotations = testMapView.annotations
        testMapView.removeAnnotations(annotations)
    }

    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる。
        testSearchBar.resignFirstResponder()
        
        // 既存のピンを削除
        removeAnnotations()
        
        // 検索条件を作成する。
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = testSearchBar.text
        request.region = testMapView.region
        
        let localSearch = MKLocalSearch(request: request)
        
        localSearch.start { (result, error) in
            if let placemark = result?.mapItems.first?.placemark,
               error == nil {
                // 検索された場所にピンを刺す。
                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.coordinate
                annotation.title = placemark.name
                annotation.subtitle = placemark.title
                self.testMapView.addAnnotation(annotation)
                
                // 選択された建物の名前と座標を変数に代入
                self.selectedPlaceName = placemark.name
                self.selectedPlaceCoordinate = placemark.coordinate
                
                // 選択された場所の名前をラベルに表示
                self.posNameLabel.text = placemark.name
                print(annotation.title)
            } else {
                
                // エラー
                print(error)
            }
        }
    }
    
    func creatItem(item: addMapItem){
        try! realm.write{
            realm.add(item)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }

}

extension addMapViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
