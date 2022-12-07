//
//  StationFacilities.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/08.
//

import Foundation

struct TbSeoulmetroStConve:Codable {
    let row: [SFacilities] 
}
struct SFacilities:Codable{
    let STATION_NAME:String
    let LINE:String
    let EL:String
    let WL:String
    let PARKING:String
    let BICYCLE:String
    let CIM:String
    let EXCHANGE:String
    let TRAIN:String
    let CULTURE:String
    let PLACE:String
    let FDROOM:String
}
