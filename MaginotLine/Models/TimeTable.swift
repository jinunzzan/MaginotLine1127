//
//  StationResponse.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/18.
//

// 지하철 전체시간표 api
import Foundation

struct Time:Codable{
    var line_num: String //호선!
    var fr_code: String//외부코드!
    var station_cd: String //전철역코드!
    var station_nm: String//전철역명!
    var train_no: String//열차번호
    var arriveTime: String//도착시간
    var leftTime: String//출발시간
    var originStation: String //출발지하철역코드
    var destStation: String //도착지하철역코드
    var subwaySName: String//출발지하철역명
    var subwayEName: String//도착지하철역명
    var week_tag: String//요일
    var inout_tag: String//상/하행선
    var fl_flag: String//플러그
    var destStation2: String//도착역 코드2
    var express_yn: String//급행선
    var branch_line: String //지선
    
    enum CodingKeys: String, CodingKey {
        case line_num = "LINE_NUM"
        case fr_code = "FR_CODE"
        case station_cd = "STATION_CD"
        case station_nm = "STATION_NM"
        case train_no = "TRAIN_NO"
        case arriveTime = "ARRIVETIME"
        case leftTime = "LEFTTIME"
        case originStation = "ORIGINSTATION"
        case destStation = "DESTSTATION"
        case subwaySName = "SUBWAYSNAME"
        case subwayEName = "SUBWAYENAME"
        case week_tag = "WEEK_TAG"
        case inout_tag = "INOUT_TAG"
        case fl_flag = "FL_FLAG"
        case destStation2 = "DESTSTATION2"
        case express_yn = "EXPRESS_YN"
        case branch_line = "BRANCH_LINE"
        
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.line_num = try container.decode(String.self, forKey: .line_num)
        self.fr_code = try container.decode(String.self, forKey: .fr_code)
        self.station_cd = try container.decode(String.self, forKey: .station_cd)
        self.station_nm = try container.decode(String.self, forKey: .station_nm)
        self.train_no = try container.decode(String.self, forKey: .train_no)
        self.arriveTime = try container.decode(String.self, forKey: .arriveTime)
        self.leftTime = try container.decode(String.self, forKey: .leftTime)
        self.originStation = try container.decode(String.self, forKey: .originStation)
        self.destStation = try container.decode(String.self, forKey: .destStation)
        self.subwaySName = try container.decode(String.self, forKey: .subwaySName)
        self.subwayEName = try container.decode(String.self, forKey: .subwayEName)
        self.week_tag = try container.decode(String.self, forKey: .week_tag)
        self.inout_tag = try container.decode(String.self, forKey: .inout_tag)
        self.fl_flag = try container.decode(String.self, forKey: .fl_flag)
        self.destStation2 = try container.decode(String.self, forKey: .destStation2)
        self.express_yn = try container.decode(String.self, forKey: .express_yn)
        self.branch_line = try container.decode(String.self, forKey: .branch_line)
    }
}

struct TimeTable: Codable {
    var list_total_count: Int
    var row: [Time]
}

struct TimeResult: Codable {
    var SearchSTNTimeTableByIDService: TimeTable
}
