//
//  MaginotListTableViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//


//마지노선 리스트
import UIKit
import Alamofire

class MaginotListTableViewController: UITableViewController {
    var timeTable:[Time]=[]
    var time:Time?
    var timeResult:Time?
    var timeList:TimeTable?
    var listTime: TimeResult?
    // 받아올 stringData
    
    var strStartStationCD:String = ""
    var strEndStationCD:String = ""
    var strMaginotTime:String = ""
    var strToday:String = ""
    var strStartFrCode = ""
    var strEndFrCode = ""
    var subWayLeadTimeSeconds:Double = 0
    //출발시간+ 소요시간
    var strArriveTime = ""
    // strArriveTime이 들어갈 배열
    
    // 시간표 api
    let apiKey = "4172664e4e6c6f763130366746444b72"
    let type = "json"
    let serviceKey = "SearchSTNTimeTableByIDService"
    var start_index = 1 //요청시작위치
    var end_index = 5 //요청종료위치
    var station_cd = "2561" //전철역코드
    var week_tag = "1" //요일
    
    // 소요시간 api
    var route:Result?
    //1. var exchangeInfoSet:ExChangeInfo? - nil값 나옴
    var exchangeInfoSet:ExChangeInfoSet?
    //환승시간 변수
    var transMinute:Int?
    var inout_tag:String? //상/하행선
    var wayCode:Int = -1 //상하행선
    
    
    
    // fr_code 사용
    let apiKeyOdi:String = "Uod2LyinNkpHwAVsJrWBBA"
    let sid = 202
    let eid = 222
    
    // 도착시간 배열
    var timeArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        print(timeTable)
        print("마지노선 출발역cd: \(strStartStationCD)")
        print("마지노선 도착역cd: \(strEndStationCD)")
        print("마지노선 출발역fr_cd: \(strStartFrCode)")
        print("마지노선 도착역fr_cd: \(strEndFrCode)")
        print("마지노선 시간: \(strMaginotTime)")
        print("마지노선 요일코드: \(strToday)")
        print("마지노선 상하행선코드: \(inout_tag ?? "")")
        
        // 마지노선 구하는 방법은? 마지노선 시간 - 소요시간 에 도착시간이 가장 가까운 열차
        
        //        searchTimeTable(start_index: 1, end_index: 5, station_cd: strStartStationCD, week_tag: strToday, inout_tag: "1")
        searchSubwayPath(strStartFrCode ?? "", strEndFrCode ?? "")
    }
    
    //즐겨찾기 버튼 클릭
    @IBAction func addFavorite(_ sender: Any) {
        
    }
    
    
    func searchTimeTable(start_index:Int, end_index:Int,  station_cd:String, week_tag:String, inout_tag:String){
        
        let str = "http://openAPI.seoul.go.kr:8088/\(apiKey)/\(type)/\(serviceKey)/\(start_index)/\(end_index)/\(station_cd)/\(week_tag)/\(inout_tag)/"
        print(str)
        
        let alamo = AF.request(str, method: .get)
        
        alamo.responseDecodable(of: TimeResult.self)
        { [self] response in print(response)
            guard let result = response.value else {return}
            self.timeTable = result.SearchSTNTimeTableByIDService.row
            print(self.timeTable)
            
            // 데이터 포맷 변환
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            // 지금 현재 날짜 / 시간을 데이터 포맷에 맞춰 담기
            let strToday = formatter.string(from: Date())
            
            // 시간:분:초로 데이터 포맷 확장
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // 지하철 총 소요시간을 ** 분으로 맞춰서 더할 수 있게 한 거
            //            print("지하철 소요시간: \(self.route?.globalTravelTime)")
            var subWayLeadTime = Double(self.route?.globalTravelTime ?? Int(0.0))
            print("지하철 소요시간: \(subWayLeadTime)")
            //            var minTime = "\(strToday) \(self.timeTable[0].leftTime)"
            
            var maginotTime = "\(strToday) \(strMaginotTime)"
            var dateMagino = formatter.date(from: maginotTime)
            
            
            guard let dateMagino = dateMagino?.addingTimeInterval(subWayLeadTime * -60.0) //
            else { fatalError() }
            formatter.dateFormat = "HH:mm:ss"
            let strMagino = formatter.string(from: dateMagino)
            print("strMagino \(strMagino)")
            
            
            var tempTimeTable = self.timeTable.filter { time in
                time.leftTime < strMagino
                
            }
            tempTimeTable.reverse()
            
            if tempTimeTable.count > 5 {
                let tempTimeTable1 = Array(tempTimeTable[0..<5])
                self.timeTable = tempTimeTable1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
            
            subWayLeadTimeSeconds = subWayLeadTime * 60
            formatter.dateFormat = "yyyy-MM-dd"
            var patchDate = formatter.string(from: Date())
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var patchDatePlus = "\(patchDate) \(strMagino)"
            print("이건 오늘날짜 + 마지노선 타임 입니다\(patchDatePlus)")
            
            
            
            print("//////////////////////////////")
            print(self.timeTable)
            print("//////////////////////////////")
            
            
            
        }
        
    }
    
    
    func searchSubwayPath(_ sid:String,_ eid:String){
        let str = "https://api.odsay.com/v1/api/subwayPath"
        let params:Parameters = ["apiKey":apiKeyOdi, "lang":0, "output":"json", "CID":1000, "SID":sid, "EID":eid]
        let alamo = AF.request(str, method: .get, parameters: params)
        
        alamo.responseDecodable(of: Root.self)
        { response in
            print(response)
            guard let result = response.value else { return }
            self.route = result.result
            
            
            
            print("==================")
            print("전체 운행소요시간\(self.route?.globalTravelTime)")
            print("==================")
            self.exchangeInfoSet = self.route?.exChangeInfoSet
            if let infoSet = self.exchangeInfoSet {
                print("환승역ID:\(infoSet.exChangeInfo[0].exSID)")
                print("환승소요시간(초):\(infoSet.exChangeInfo[0].exWalkTime)")
                self.transMinute = infoSet.exChangeInfo[0].exWalkTime / 60
                if (self.transMinute ?? 0) % 60 == 0 {
                    self.transMinute = self.transMinute
                } else {
                    self.transMinute! += 1
                }
                print("환승소요시간(분): \(self.transMinute)분")
                print("==================")
            } else {
                print("전체 운행소요시간\(self.route?.globalTravelTime)")
            }
            
            
            let strWayCode = "\(result.result.driveInfoSet.driveInfo[0].wayCode)"
            print("wayCode:\(strWayCode)")
            self.searchTimeTable(start_index: 1, end_index: 500, station_cd: self.strStartStationCD, week_tag: self.strToday, inout_tag: strWayCode )
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return timeTable.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maginotcell", for: indexPath)
        
        let time = timeTable[indexPath.row]
        
        let lblStart = cell.viewWithTag(1) as? UILabel
        lblStart?.text = time.station_nm
        let lblStartTime = cell.viewWithTag(2) as? UILabel
        lblStartTime?.text = time.arriveTime
        
        let lblEnd = cell.viewWithTag(3) as? UILabel
        lblEnd?.text = self.route?.globalEndName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        
        let leftTime = "\(today) \(time.leftTime)"
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateLeftTime = formatter.date(from: leftTime)
        guard let dateLeftTime1 = dateLeftTime?.addingTimeInterval(subWayLeadTimeSeconds)
        else {fatalError()}
        
        formatter.dateFormat = "HH:mm:ss"
        
        
        let lblEndTime = cell.viewWithTag(4) as? UILabel
        lblEndTime?.text = formatter.string(from: dateLeftTime1)
        
        return cell
    }
    
}
