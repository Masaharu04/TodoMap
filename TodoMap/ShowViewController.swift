import UIKit
import MapKit
import RealmSwift

class ShowViewController: UIViewController {
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    var item: addMapItem?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = item?.date
        titleLabel.text = item?.title
        subtitleLabel.text = item?.maptitle
        memoTextView.text = item?.memo
        
        // Realmから座標情報を取得
        if let latitude = item?.posLatitude, let longitude = item?.posLongitude {
            // CLLocationCoordinate2Dを作成
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            // マップ上にピンを立てる
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = item?.title
            
            MapView.addAnnotation(annotation)
            
            // マップを座標に合わせて表示
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            MapView.setRegion(region, animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back() {
        self.dismiss(animated: true)
    }
}
