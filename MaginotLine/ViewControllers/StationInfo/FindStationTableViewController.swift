//
//  FindStationTableViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/05.
//

import UIKit
import Alamofire

class FindStationTableViewController: UITableViewController {
    

    var line: Station?
    var stations: [Station] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        searchBar.delegate = self
        
        requestFirstStation(from: "")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if stations.count > 0 {
            return 1
        } else {
            return 22
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath)
        let station = stations[indexPath.row]
        
        let lblName = cell.viewWithTag(2) as? UILabel
        lblName?.text = station.station_nm
        
        let lblLine = cell.viewWithTag(3) as? UILabel
        lblLine?.text = "\(station.line_num)"
        
        let lineImage = cell.viewWithTag(1) as? UIImageView
        switch station.line_num {
        case "01호선":
            lineImage?.image = UIImage(named: "1line")
        case "02호선" :
            lineImage?.image = UIImage(named: "2line")
        case "03호선" :
            lineImage?.image = UIImage(named: "3line")
        case "04호선" :
            lineImage?.image = UIImage(named: "4line")
        case "05호선" :
            lineImage?.image = UIImage(named: "5line")
        case "06호선" :
            lineImage?.image = UIImage(named: "6line")
        case "07호선" :
            lineImage?.image = UIImage(named: "7line")
        case "08호선" :
            lineImage?.image = UIImage(named: "8line")
        case "09호선" :
            lineImage?.image = UIImage(named: "9line")
        case "공항철도" :
            lineImage?.image = UIImage(named: "airline")
        case "경의선" :
            lineImage?.image = UIImage(named: "kcline")
        case "수인분당선" :
            lineImage?.image = UIImage(named: "sbline")
        case "인천선" :
            lineImage?.image = UIImage(named: "ic1line")
        case "경강선" :
            lineImage?.image = UIImage(named: "kkline")
        case "신분당선" :
            lineImage?.image = UIImage(named: "sbdline")
        case "용인경전철" :
            lineImage?.image = UIImage(named: "yyline")
        case "신림선" :
            lineImage?.image = UIImage(named: "slline")
        case "우이신설경전철" :
            lineImage?.image = UIImage(named: "wsline")
        case "의정부경전철" :
            lineImage?.image = UIImage(named: "ujbline")
        case "경춘선" :
            lineImage?.image = UIImage(named: "kchline")
        case "김포도시철도" :
            lineImage?.image = UIImage(named: "ggline")
        default:
            lineImage?.image = UIImage(named: "1line")
        }
        
        return cell
    }
}


/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

//searchBar delegate
extension FindStationTableViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing (_ searchBar: UISearchBar) {
        
        //검색어 변경하면 테이블 다시 그려주어야함
        tableView.reloadData()
        tableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            return
        }
        requestStation(from: searchText)
    }
}

// REST API
extension FindStationTableViewController{
    func requestStation(from station: String){
        let url = "http://openAPI.seoul.go.kr:8088/43464a45546c6f7634344855706b57/json/SearchInfoBySubwayNameService/1/5/\(station)"
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationRespose.self){[weak self] response in guard case .success(let data) = response.result else {return}
                
                //데이터 받기
                self?.stations = data.stations
                //테이블뷰 다시 그리기
                self?.tableView.reloadData()
            }
            .resume()
    }
}

extension FindStationTableViewController{
    func requestFirstStation(from station: String){
        let url = "http://openAPI.seoul.go.kr:8088/43464a45546c6f7634344855706b57/json/SearchInfoBySubwayNameService/1/767/"
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationRespose.self){[weak self] response in guard case .success(let data) = response.result else {return}
                
                //데이터 받기
                self?.stations = data.stations
                //테이블뷰 다시 그리기
                self?.tableView.reloadData()
            }
            .resume()
    }
}
