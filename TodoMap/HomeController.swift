//
//  ViewController.swift
//  TodoMap
//
//  Created by 御前政喜 on 2023/09/18.
//
import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var homeMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 指定された座標を作成
        let coordinate = CLLocationCoordinate2D(latitude: 34.7024, longitude: 135.4959)
        
        // アノテーションを作成
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "ラーメンを食べにいく"
        annotation.subtitle = "10月８日"
        
        // マップビューにアノテーションを追加
        homeMapView.addAnnotation(annotation)
        
        // マップビューの表示領域を指定された座標にズーム
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        homeMapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let reuseIdentifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
            annotationView?.calloutOffset = CGPoint(x: -5, y: 5)

            // カスタムビューを読み込む
            if let customPinView = Bundle.main.loadNibNamed("CustomPinView", owner: self, options: nil)?.first as? CustomPinView {
                customPinView.titleLabel.text = annotation.title ?? ""
                customPinView.dateLabel.text = annotation.subtitle ?? ""

                annotationView?.detailCalloutAccessoryView = customPinView
            }
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

}

