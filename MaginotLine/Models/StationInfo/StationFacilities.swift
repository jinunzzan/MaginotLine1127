//
//  StationFacilities.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/08.
//

import Foundation

struct Welcome: Codable {
    let tbSeoulmetroStConve: TBSeoulmetroStConve

    enum CodingKeys: String, CodingKey {
        case tbSeoulmetroStConve = "TbSeoulmetroStConve"
    }
}

// MARK: - TBSeoulmetroStConve
struct TBSeoulmetroStConve: Codable {
    let row: [Row]

    enum CodingKeys: String, CodingKey {
        case row
    }
}

// MARK: - Row
struct Row: Codable {
    let stationID, stationName, line, el: String
    let wl, parking, cim: String
    let exchange, train, culture, place: String
    let fdroom: String

    enum CodingKeys: String, CodingKey {
        case stationID = "STATION_ID"
        case stationName = "STATION_NAME"
        case line = "LINE"
        case el = "EL"
        case wl = "WL"
        case parking = "PARKING"
        case cim = "CIM"
        case exchange = "EXCHANGE"
        case train = "TRAIN"
        case culture = "CULTURE"
        case place = "PLACE"
        case fdroom = "FDROOM"
    }
}
