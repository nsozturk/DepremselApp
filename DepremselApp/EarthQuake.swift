//
//  EarthQuake.swift
//  DepremCell
//
//  Created by enes öztürk on 26.03.2023.
//

import Foundation

struct EarthQuake: Codable {
    let status: Bool?
    let httpStatus, serverloadms: Int?
    let desc: String?
    let metadata: Metadata
    let result: [Result]
}

// MARK: - Metadata

struct Metadata: Codable {
    let dateStarts, dateEnds: String?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case dateStarts = "date_starts"
        case dateEnds = "date_ends"
        case total
    }
}

// MARK: - Result

struct Result: Codable {
    let id, earthquakeID, title: String?
    let date: String?
    let mag, depth: Double?
    let geojson: Geojson?
    //let locationProperties: LocationProperties?
    //let rev: JSONNull?
    //let dateTime: String?
    //let createdAt: Int?
    //let locationTz: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case earthquakeID = "earthquake_id"
        case title, date, mag, depth, geojson
        //case locationProperties = "location_properties"
        //case rev
        //case dateTime = "date_time"
       // case createdAt = "created_at"
       // case locationTz = "location_tz"
    }
}

// MARK: - Geojson

struct Geojson: Codable {
    let type: String?
    let coordinates: [Double]?
}

// MARK: - LocationProperties

//struct LocationProperties: Codable {
//    let closestCity, epiCenter: ClosestCity?
//    let closestCities: [ClosestCity]?
//    let airports: [Airport]?
//}

// MARK: - Airport

struct Airport: Codable {
    let distance: Double?
    let name, code: String?
    let coordinates: Geojson?
}

// MARK: - ClosestCity

struct ClosestCity: Codable {
    let name: String?
    let cityCode: Int?
    let distance: Double?
    let population: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
