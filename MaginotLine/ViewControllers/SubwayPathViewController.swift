//
//  SubwayPathViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/21.
//


//소요시간, 환승시간
import UIKit
import Alamofire

class SubwayPathViewController: UIViewController {
    var route:Result?
    //1. var exchangeInfoSet:ExChangeInfo? - nil값 나옴
    var exchangeInfoSet:ExChangeInfoSet?
    
    // fr_code 사용
    let apiKey:String = "Uod2LyinNkpHwAVsJrWBBA"
    let sid = "202"
    let eid = "222"

    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        metroLine("520","417")
        // Do any additional setup after loading the view.
        
        
        // URLSession.shared.dataTask(with: url)
        
    }
    func metroLine(_ sid:String,_ eid:String){
        let str = "https://api.odsay.com/v1/api/subwayPath"
        let params:Parameters = ["apiKey":apiKey, "lang":0, "output":"json", "CID":1000, "SID":sid, "EID":eid]
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
                guard let infoSet = self.exchangeInfoSet else { fatalError()}
                print("환승역ID:\(infoSet.exChangeInfo[0].exSID)")
                print("환승소요시간:\(infoSet.exChangeInfo[0].exWalkTime)")
                print("==================")
                
        }
    }

}

