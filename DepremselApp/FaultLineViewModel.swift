//
//  FaultLineViewModel.swift
//  FayHat
//
//  Created by enes öztürk on 30.03.2023.
//

import CoreLocation
import MapKit
import UIKit

class FaultLineViewModel {
    var faultInfo: [Feature] = []

    func loadGeoJSONFile(on mapView: MKMapView) {
        guard let url = Bundle.main.url(forResource: "tr_faults_imp", withExtension: "geojson") else {
            fatalError("Could not find file")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let fault = try decoder.decode(Fault.self, from: data)
            let faultFeatures = fault.features
            for faultFeature in faultFeatures {
                let fid = faultFeature.properties.fid
                let rate = faultFeature.properties.rate
                let conf = faultFeature.properties.conf
                let sens1 = faultFeature.properties.sens1
                let sens2 = faultFeature.properties.sens2
                let upside = faultFeature.properties.upside
                let zoneName = faultFeature.properties.zoneName
                let faultName = faultFeature.properties.faultName
                let auth = faultFeature.properties.auth
                let parm = faultFeature.properties.parm
                let text = faultFeature.properties.text
                let faultID = faultFeature.properties.faultID
                let importance = faultFeature.properties.importance
                // type
                let featureType = faultFeature.type
                // location
                let type = faultFeature.geometry.type
                let coordinates = faultFeature.geometry.coordinates
                // let newFeature = Geometry(type: type, coordinates: coordinates)
                let newFeature = Feature(type: featureType, properties: FeatureProperties(fid: fid, rate: rate, conf: conf, sens1: sens1, sens2: sens2, upside: upside, zoneName: zoneName, faultName: faultName, auth: auth, parm: parm, text: text, faultID: faultID, importance: importance), geometry: Geometry(type: type, coordinates: coordinates))
                faultInfo.append(newFeature)
            }
            drawFault(for: faultInfo, on: mapView)

        } catch {
            print("Error loading GeoJSON data: \(error.localizedDescription)")
        }
    }

//    func drawFault(for faultFeautures: [Feature], on mapView: MKMapView) {
//        for faultFeauture in faultFeautures {
//            let faultCoordinate = faultFeauture.geometry.coordinates
//            let faultRate = faultFeauture.properties.rate
//            let faultConf = faultFeauture.properties.conf
//            let faultInfo = faultFeauture.properties.importance
//
//            var polylineCoordinates = [CLLocationCoordinate2D]()
//            for coordinate in faultCoordinate {
//                let lat = coordinate[1]
//                let lon = coordinate[0]
//
//                let polylineCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//                polylineCoordinates.append(polylineCoordinate)
//            }
//
//            let polyline = MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
//            polyline.title? = "\(faultFeauture.properties.faultID)"
//            mapView.addOverlay(polyline)
//        }
//    }

    func drawFault(for features: [Feature], on mapView: MKMapView) {
        for feature in features {
            let coordinates = feature.geometry.coordinates

            var polylineCoordinates = [CLLocationCoordinate2D]()
            for coordinate in coordinates {
                let lat = coordinate[1]
                let lon = coordinate[0]
                let polylineCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                polylineCoordinates.append(polylineCoordinate)
            }

            let polyline = MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
            mapView.addOverlay(polyline)
        }
    }
}
