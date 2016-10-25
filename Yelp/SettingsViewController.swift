//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Ben Jones on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDidSaveSettings(controller: SettingsViewController, newValue:SearchSettings)
}

class SettingsViewController: UIViewController {
    
    var distanceExpanded : Bool = false
    var sortExpanded : Bool = false
    var searchSettings : SearchSettings = SearchSettings()
    let filterSections = ["Most Popular", "Distance", "Sort By", "Category"]
    weak var delegate: SettingsViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "SwitchSettingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SwitchSettingTableViewCell")
       
        //tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        
        
    }
    

    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        delegate?.settingsViewControllerDidSaveSettings(controller: self, newValue: searchSettings.copy() as! SearchSettings)
        dismiss(animated: true, completion: nil)
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

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case 0:
            count = 1
        case 1:
            count = distanceExpanded ? SearchSettings.distanceOptions.count : 1
        case 2:
            count = sortExpanded ? 3 : 1
        case 3:
            count = SearchSettings.categoryOptions.count
        default:
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        switch indexPath.section {
        case 0:
            let settingCell = tableView.dequeueReusableCell(withIdentifier: "SwitchSettingTableViewCell", for: indexPath as IndexPath) as! SwitchSettingTableViewCell
            settingCell.title.text = "Offering a Deal"
            settingCell.value = "deal"
            settingCell.category = "popular"
            settingCell.switchControl.isOn = searchSettings.deal
            settingCell.delegate = self
            cell = settingCell
        case 1:
            cell = UITableViewCell()
            if(distanceExpanded){
                let key = Array(SearchSettings.distanceOptions.keys)[indexPath.row]
                cell.textLabel?.text = SearchSettings.distanceOptions[key]
                cell.imageView?.image = searchSettings.distance == key ? #imageLiteral(resourceName: "leftArrowBlue") : #imageLiteral(resourceName: "leftArrowGrey")
            } else {
                cell.textLabel?.text = SearchSettings.distanceOptions[searchSettings.distance]
                cell.imageView?.image = #imageLiteral(resourceName: "downArrow")
            }
            
        case 2:
            cell = UITableViewCell()
            if(sortExpanded){
                cell.textLabel?.text = SearchSettings.searchModeOptionNames[indexPath.row]
                cell.imageView?.image = searchSettings.sortMode.rawValue == indexPath.row ? #imageLiteral(resourceName: "leftArrowBlue") : #imageLiteral(resourceName: "leftArrowGrey")
            } else {
                cell.textLabel?.text = SearchSettings.searchModeOptionNames[searchSettings.sortMode.rawValue]
                cell.imageView?.image = #imageLiteral(resourceName: "downArrow")
            }
        case 3:
            let settingCell = tableView.dequeueReusableCell(withIdentifier: "SwitchSettingTableViewCell", for: indexPath as IndexPath) as! SwitchSettingTableViewCell
            let key = Array(SearchSettings.categoryOptions.keys)[indexPath.row]
            settingCell.title.text = SearchSettings.categoryOptions[key]
            settingCell.value = key
            settingCell.category = "category"
            settingCell.switchControl.isOn = searchSettings.categories.index(of: key) != nil
            settingCell.delegate = self
            cell = settingCell
        default:
            cell = UITableViewCell()
            cell.textLabel?.text = "?"
        }
        

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1) {
            if(distanceExpanded){
                distanceExpanded = false
                searchSettings.distance = Array(SearchSettings.distanceOptions.keys)[indexPath.row]
            } else {
                distanceExpanded = true
            }
            
            tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
        } else if (indexPath.section == 2){
            if(sortExpanded){
                sortExpanded = false
                searchSettings.sortMode = YelpSortMode(rawValue: indexPath.row) ?? YelpSortMode.highestRated
            } else {
                sortExpanded = true
            }
            tableView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .automatic)
        }
    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier) as UITableViewHeaderFooterView
//        header.textLabel.text = data[section][0]
//        return header
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSections[section]
    }
    
}
extension SettingsViewController: SwitchSettingTableViewCellDelegate {
    func switchSettingsCellDidToggle(cell: SwitchSettingTableViewCell, newValue: Bool) {
        if cell.category == "popular" {
            self.searchSettings.deal = newValue
        } else if(cell.category == "category") {
            if let catIndex = searchSettings.categories.index(of: cell.value) {
                searchSettings.categories.remove(at: catIndex)
            } else {
                searchSettings.categories.append(cell.value)
            }
        }
    }
}
