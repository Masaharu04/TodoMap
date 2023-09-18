//
//  addMapViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//

import UIKit
import MapKit

class addMapViewController: UIViewController ,UISearchBarDelegate{
    
    @IBOutlet var testSearchBar: UISearchBar!
    @IBOutlet weak var testMapView: MKMapView!
    @IBOutlet var posNameLabel: UILabel!
    
    var pos:[String] = []
    
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
    
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる。
        testSearchBar.resignFirstResponder()
        
        //検索条件を作成する。
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = testSearchBar.text
        
        let localSearch:MKLocalSearch = MKLocalSearch(request: request)

        localSearch.start(completionHandler: {(result, error) in
            
            for placemark in (result?.mapItems)! {
                if(error == nil) {
                    
                    //検索された場所にピンを刺す。
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(placemark.placemark.coordinate.latitude, placemark.placemark.coordinate.longitude)
                    annotation.title = placemark.placemark.name
                    annotation.subtitle = placemark.placemark.title
                    self.testMapView.addAnnotation(annotation)
                
                    pos.append(annotation.title)
                    
                } else {
                    //エラー
                    print(error)
                }
                
            }
        })
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
}
