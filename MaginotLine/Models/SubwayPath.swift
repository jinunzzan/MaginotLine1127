//
//  SubwayPath.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//


// 소요시간, 환승시간 api
import Foundation

struct Root:Codable {
    let result:Result
}
struct Result: Codable { 
    let globalStartName: String // 출발역 명
    let globalEndName: String // 도착역 명
    let globalTravelTime: Int // 전체 운행소요시간(분)
    let globalDistance: Double // 전체 운행거리(Km)
    let globalStationCount: Int // 전체 정차역 수
    let fare:Int // 카드 요금
    let cashFare:Int // 현금 요금
    let driveInfoSet:DriveInfoSet // 현금요금
    let exChangeInfoSet:ExChangeInfoSet? // 환승 정보
    let stationSet:StationSet // 이동역 정보 그룹
}

struct DriveInfoSet: Codable { // 현금요금
    let driveInfo: [DriveInfo]
}

struct DriveInfo: Codable {
    let laneID:String // 승차역 ID
    let laneName:String // 승차역 호선명
    let startName: String // 승차 역명
    let stationCount: Int // 이동역 수
    let wayCode: Int // 방면코드 (1:상행 / 2:하행)
    let wayName: String // 방면 명
}

struct ExChangeInfoSet:Codable { // 환승정보
    let exChangeInfo:[ExChangeInfo]
}

struct ExChangeInfo:Codable {
    let laneName: String // 승차노선 명
    let startName: String // 승차역 명
    let exName: String // 환승명
    let exSID: Int // 환승역 ID
    let fastTrain: Int // 빠른 환승 객차 번호
    let fastDoor: Int // 빠른 환승 객차 문 번호
    let exWalkTime: Int // 환승 소요시간
}
struct StationSet:Codable {
    let stations: [Stations]
}
struct Stations:Codable { // 이동역 정보 그룹
    let startID: Int // 출발역 ID
    let startName: String // 출발역명
    let endSID: Int // 도착역 ID
    let endName: String // 도착역 명
    let travelTime: Int // 누적 운행 시간(분)
}

