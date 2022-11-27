//
//  Struct.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/18.
//


// 지하철 실시간 도착정보 api
import Foundation

struct StationArrivalDataResponse: Codable {
    let realtimeArrivalList:[RealTimeArrivalList]
}

struct RealTimeArrivalList: Codable {
    let totalCount: Int
    let rowNum: Int
    let selcectedCount: Int
    let subwayId: String    //지하철 호선 id
    let subwayNm : String
    let updnLine: String //상행?하행?
    let trainLineNm: String // 개화행 - 노량진방면 line
    let subwayHeading: String //오른쪽
    let statnFid: String //이전 지하철역 id
    let statnTid: String//다음지하철역 id
    let statnId: String//지하철역 id
    let statnNm: String //지하철역명
    let ordkey: String //도착예정열차순번
    let subwayList:String
    let statnList: String
    let btrainSttus: String //열차종류 급행?itx?
    let barvlDt: String // 열차도착예정시간(초)
    let btrainNo: String //열차번호
    let bstatnId: String //종착지하철 Id
    let bstatnNm: String //종착 지하철역명
    let recptnDt: String //열차도착정보 생성한 시각
    let arvlMsg2: String // 전역 진입, 전역 도착 등 remaintime
    let arvlMsg3: String // 종합운동장 도착, 12분후 등 curruntstation
    let arvlCd: String // 도착코드 (0:진입, 1:도착, 2:출발, 3:전역출발, 4:전역진입, 5:전역도착, 99:운행중)
}
