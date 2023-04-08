//
//  MapViewController.swift
//  FayHat
//
//  Created by enes öztürk on 30.03.2023.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    let viewModel = FaultLineViewModel()
    var eqDetails = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel.loadGeoJSONFile(on: mapView)
    }
}

// extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if let polyLine = overlay as? MKPolyline {
//            let renderer = MKPolylineRenderer(polyline: polyLine)
//            renderer.lineCap = .round
//            renderer.lineJoin = .round
//            if let title = polyLine.title {
//                let feature = viewModel.faultInfo.first(where: { $0.properties.faultID == title })
//                let rate = feature?.properties.rate ?? "0"
//                let conf = feature?.properties.conf ?? "Unkown"
//
//                switch (Int(rate), conf) {
//                case (1, "A"):
//                    renderer.strokeColor = UIColor(named: "FaultColor4")!
//                    renderer.lineWidth = 1
//                case (2, "A"):
//                    renderer.strokeColor = UIColor(named: "FaultColor4")!
//                    renderer.lineWidth = 1.5
//                case (3, "A"):
//                    renderer.strokeColor = UIColor(named: "FaultColor3")!
//                    renderer.lineWidth = 2
//                case (1, "B"):
//                    renderer.strokeColor = UIColor(named: "FaultColor2")!
//                    renderer.lineWidth = 2.2
//                case (2, "B"):
//                    renderer.strokeColor = UIColor(named: "FaultColor2")!
//                    renderer.lineWidth = 2.5
//                case (3, "B"):
//                    renderer.strokeColor = UIColor(named: "FaultColor1")!
//                    renderer.lineWidth = 3
//                default:
//                    renderer.strokeColor = .gray
//                    renderer.lineWidth = 1.0
//                }
//            }
//            return renderer
//        }
//        return MKOverlayRenderer()
//    }
// }

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
}
