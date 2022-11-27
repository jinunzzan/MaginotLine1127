//
//  StationList.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//


//지하철역 리스트 api
import Foundation

struct StationRespose: Decodable {
    private let searchInfo: SearchInfoBySubwayNameService

    //간단하게 쓸 수 있도록 연산프로퍼티 사용
    var stations: [Station] {searchInfo.row}

    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }

}

struct SearchInfoBySubwayNameService: Decodable{
    var row: [Station] = []
}

struct Station: Decodable {
    let station_cd:String
    let station_nm:String
    let line_num:String
    let fr_code:String

    enum CodingKeys: String, CodingKey{
        case station_cd = "STATION_CD"
        case station_nm = "STATION_NM"
        case line_num = "LINE_NUM"
        case fr_code = "FR_CODE"

    }
}
