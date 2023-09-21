//
//  addMapViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//

import UIKit
import MapKit
import RealmSwift

class addMapViewController: UIViewController ,UISearchBarDelegate{
    
    let realm = try! Realm()
    
    @IBOutlet var testSearchBar: UISearchBar!
    @IBOutlet weak var testMapView: MKMapView!
    @IBOutlet var posNameLabel: UILabel!
    
    var selectedPlaceName: String?
    var selectedPlaceCoordinate: CLLocationCoordinate2D?
    
    var testManager:CLLocationManager = CLLocationManager()
    

    
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
       // let item = addMapItem()
       // item.maptitle = selectedPlaceName ?? ""
        
        performSegue(withIdentifier: "pos", sender: self)
     /*
        if let coordinate = selectedPlaceCoordinate {
            // CLLocationCoordinate2D? を文字列に変換して代入
            let coordinateString = "\(coordinate.latitude), \(coordinate.longitude)"
            item.posLatitude = coordinateString
        }
        creatItem(item: item)
        */
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


    

    //検索ボタン押下時の呼び出しメソッド

      //  posNameLabel.text = String(pos)
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    
}

extension addMapViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
