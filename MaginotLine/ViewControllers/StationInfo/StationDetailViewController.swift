//
//  StationDetailViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/06.
//

import UIKit
import Alamofire
class StationDetailViewController: UIViewController {
    
    
    @IBOutlet weak var lineBackground: UIImageView!
    @IBOutlet weak var stationName: UILabel!
//첫번째열차
    @IBOutlet weak var lblDir1: UILabel!
    @IBOutlet weak var lblArvMsg1: UILabel!
    
    //두번째열차
    @IBOutlet weak var lblDir2: UILabel!
    @IBOutlet weak var lblArvMsg2: UILabel!
    
    //세번째열차
    @IBOutlet weak var lblDir3: UILabel!
    @IBOutlet weak var lblArvMsg3: UILabel!
    
    //네번째 열차
    @IBOutlet weak var lblDir4: UILabel!
    @IBOutlet weak var lblArvMsg4: UILabel!
    
    
    var stations:Station?
    var realtimeArrivalList: [RealTimeArrivalList] = []
//    var realtimeArrivalList1: [RealTimeArrivalList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let station = stations else {return}
        
        switch station.line_num {
        case "01호선":
            lineBackground.image = UIImage(named: "1detail")
        case "02호선" :
            lineBackground.image = UIImage(named: "2detail")
        case "03호선" :
            lineBackground.image = UIImage(named: "3detail")
        case "04호선" :
            lineBackground.image = UIImage(named: "4detail")
        case "05호선" :
            lineBackground.image = UIImage(named: "5detail")
        case "06호선" :
            lineBackground.image = UIImage(named: "6detail")
        case "07호선" :
            lineBackground.image = UIImage(named: "7detail")
        case "08호선" :
            lineBackground.image = UIImage(named: "8detail")
        case "09호선" :
            lineBackground.image = UIImage(named: "9detail")
        case "공항철도" :
            lineBackground.image = UIImage(named: "airportdetail")
        case "경의선" :
            lineBackground.image = UIImage(named: "kecenterdetail")
        case "수인분당선" :
            lineBackground.image = UIImage(named: "sibddetail")
        case "인천선" :
            lineBackground.image = UIImage(named: "ic1detail")
        case "경강선" :
            lineBackground.image = UIImage(named: "kkdetail")
        case "신분당선" :
            lineBackground.image = UIImage(named: "sbddetail")
        case "용인경전철" :
            lineBackground.image = UIImage(named: "yydetail")
        case "신림선" :
            lineBackground.image = UIImage(named: "sinlimdetail")
        case "우이신설경전철" :
            lineBackground.image = UIImage(named: "wissdetail")
        case "의정부경전철" :
            lineBackground.image = UIImage(named: "ugbdetail")
        case "경춘선" :
            lineBackground.image = UIImage(named: "kcdetail")
        case "김포도시철도" :
            lineBackground.image = UIImage(named: "gpgolddetail")
        default:
            lineBackground.image = UIImage(named: "2detail")
        }
        stationName.text = station.station_nm
        guard let selectStation = stationName.text else {fatalError()}
        requestStationNameis(from: selectStation)
        print(realtimeArrivalList)
        
    }
    
}

extension StationDetailViewController{
  func requestStationNameis(from station: String){
        
        
        guard let station = stations else {return}
        
        let url = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(station.station_nm)"
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDataResponse.self){[weak self] response in guard
                case .success (let data) = response.result else {return}
                self?.realtimeArrivalList = data.realtimeArrivalList
                
                let count = self!.realtimeArrivalList.count
                if  count > 0 {
                        //첫번째열차
                        self?.lblDir1.text = (self?.realtimeArrivalList[0].bstatnNm ?? "") + " 행"
                        self?.lblArvMsg1.text = self?.realtimeArrivalList[0].arvlMsg2
                    if count>1{
                        //두번째열차
                        self?.lblDir2.text = (self?.realtimeArrivalList[1].bstatnNm ?? "") + " 행"
                        self?.lblArvMsg2.text = self?.realtimeArrivalList[1].arvlMsg2
                    }
                    if count>2{
                        //세번째열차
                        self?.lblDir3.text = (self?.realtimeArrivalList[2].bstatnNm ?? "") + " 행"
                        self?.lblArvMsg3.text = self?.realtimeArrivalList[2].arvlMsg2
                    }
                    if count>3{
                        //네번째열차
                        self?.lblDir4.text = (self?.realtimeArrivalList[3].bstatnNm ?? "") + " 행"
                        self?.lblArvMsg4.text = self?.realtimeArrivalList[3].arvlMsg2
                    }
                }
                
                
                
                print(self?.realtimeArrivalList ?? "")
            }
        
    }
}
