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
    
    var stations:Station?
    
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
