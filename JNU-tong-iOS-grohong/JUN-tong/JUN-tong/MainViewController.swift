//
//  MainViewController.swift
//  JUN-tong
//
//  Created by Seong ho Hong on 2017. 9. 16..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cityBusMain: UIView!
    @IBOutlet weak var shuttleBusMain: UIView!
    
    @IBOutlet weak var cityBusTable: UITableView!
    
    var mainView = true
    // 본래 있던 자리를 알기 위해
    var shuttleBusCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityBusTable.delegate = self
        cityBusTable.dataSource = self
        cityBusTable.isScrollEnabled = false
        
        shuttleBusCenter = shuttleBusMain.center
        
        cityBusMain.layer.borderColor = UIColor.darkGray.cgColor
        cityBusMain.layer.borderWidth = 0.5
        cityBusMain.layer.cornerRadius = 7
        
        shuttleBusMain.layer.borderColor = UIColor.darkGray.cgColor
        shuttleBusMain.layer.borderWidth = 0.5
        shuttleBusMain.layer.cornerRadius = 7
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cityBusMainCell", for: indexPath) as? CityBusMainCell {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && self.mainView == true {
            self.mainView = false
            UIView.animate(withDuration: 0.5,delay: 0, animations: {
                self.cityBusMain.frame.size.height += self.view.bounds.height-25-180
                self.cityBusTable.frame.size.height += self.view.bounds.height-25-180
                self.cityBusTable.isScrollEnabled = true
                
                //뷰 밖으로 나갈수 있도록
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: self.shuttleBusMain.frame.height + self.view.bounds.height)
            })
        } else if indexPath.section == 0 && self.mainView == false {
            self.mainView = true
            UIView.animate(withDuration: 0.5,delay: 0, animations: {
                self.cityBusMain.frame.size.height -= self.view.bounds.height-25-180
                self.cityBusTable.frame.size.height -= self.view.bounds.height-25-180
                self.cityBusTable.isScrollEnabled = false
                
                //원래 있던 자리로(좀 엉망이네...ㅋㅋㅋ)
                self.shuttleBusMain.center = CGPoint(x: self.view.bounds.width/2, y: (self.shuttleBusCenter?.y)! - 80)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
