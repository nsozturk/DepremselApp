//
//  Fault.swift
//  FayHat
//
//  Created by enes öztürk on 30.03.2023.
//

import CoreLocation
import Foundation


struct Fault: Codable {
    let type, name: String
    let crs: CRS
    let features: [Feature]
}

// MARK: - CRS

struct CRS: Codable {
    let type: String
    let properties: CRSProperties
}

// MARK: - CRSProperties

struct CRSProperties: Codable {
    let name: String
}

// MARK: - Feature

struct Feature: Codable {
    let type: FeatureType
    let properties: FeatureProperties
    let geometry: Geometry
}

// MARK: - Geometry

struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [[Double]]
}

enum GeometryType: String, Codable {
    case lineString = "LineString"
}

// MARK: - FeatureProperties

struct FeatureProperties: Codable {
    let fid: Int
    let rate: String
    let conf: String
    let sens1, sens2: Sens
    let upside: Upside
    let zoneName, faultName, auth, parm: String
    let text, faultID: String
    let importance: Int

    enum CodingKeys: String, CodingKey {
        case fid
        case rate = "RATE"
        case conf = "CONF"
        case sens1 = "SENS1"
        case sens2 = "SENS2"
        case upside = "UPSIDE"
        case zoneName = "ZONE_NAME"
        case faultName = "FAULT_NAME"
        case auth = "AUTH"
        case parm = "PARM"
        case text = "TEXT"
        case faultID = "FAULT_ID"
        case importance
    }
}

//enum Conf: String, Codable {
//    case a = "A"
//    case b = "B"
//}

enum Sens: String, Codable {
    case d = "D"
    case e = "E"
    case empty = ""
    case n = "N"
    case r = "R"
    case s = "S"
    case t = "T"
    case u = "U"
    case v = "V"
}

enum Upside: String, Codable {
    case e = "E"
    case empty = ""
    case n = "N"
    case ne = "NE"
    case nw = "NW"
    case s = "S"
    case se = "SE"
    case sw = "SW"
    case w = "W"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}



