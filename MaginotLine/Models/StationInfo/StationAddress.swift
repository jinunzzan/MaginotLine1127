//
//  StationAddress.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/07.
//

import Foundation

struct StationAdresTelno:Codable {
    let row: [SAdress]
}

struct SAdress:Codable {
    let LINE:String
    let STATN_NM:String
    let ADRES:String
    let TELNO:String
}
