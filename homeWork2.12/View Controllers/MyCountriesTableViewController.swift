//
//  MyCountriesTableViewController.swift
//  homeWork2.12
//
//  Created by Александра Мельникова on 03.07.2021.
//

import UIKit


class MyCountriesTableViewController: UITableViewController {
    
    var oldCountriesData = StorageMyCountriesManager.shared.fetchCountryInfo()
    let newCountriesData = StorageMyCountriesManager.shared.getNewData()
    
    var expanded = Array(repeating: true, count: StorageMyCountriesManager.shared.fetchCountryInfo().count)
    
    let headerID = String(describing: CustomHeaderView.self)
    
    private func tableViewConfig() {
        let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableViewConfig()
        
        
    }
    
    
    
    
}

// MARK: Table View settings

extension MyCountriesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.oldCountriesData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !expanded[section] {
            return 0
        }
        
        return CountryInfoData.Titles.allCases.count
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        "\(GetFlag().getFlag(from: oldCountriesData[section].code)) \(oldCountriesData[section].country)"
    //    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomHeaderView
        
        
        header.configure(title: "\(GetFlag().getFlag(from: oldCountriesData[section].code)) \(oldCountriesData[section].country)", section: section)
        header.rotateImage(expanded[section])
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCountryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = CountryInfoData.Titles.allCases[indexPath.row].rawValue
        content.textProperties.color = .black
        content.textProperties.font = UIFont (name: "Apple SD Gothic Neo", size: 16)!
        

            
            let differenceConfirmed = "(+\((newCountriesData[indexPath.section].confirmed - oldCountriesData[indexPath.section].confirmed).formatting()))"
            let differenceRecovered = "(+\(newCountriesData[indexPath.section].recovered - oldCountriesData[indexPath.section].recovered))"
            let differenceCritical = "(+\(newCountriesData[indexPath.section].critical - oldCountriesData[indexPath.section].critical))"
            let differenceDeaths = "(+\(newCountriesData[indexPath.section].deaths - oldCountriesData[indexPath.section].deaths))"
        
        
        switch indexPath.row {
        case 0:
            content.secondaryText = oldCountriesData[indexPath.section].country
        case 1:
            content.secondaryText = "\(newCountriesData[indexPath.section].confirmed.formatting()) \(differenceConfirmed)"
        case 2:
            content.secondaryText = "\(newCountriesData[indexPath.section].recovered.formatting()) \(differenceRecovered)"
        case 3:
            content.secondaryText = "\(newCountriesData[indexPath.section].critical.formatting()) \(differenceCritical)"
        case 4:
            content.secondaryText = "\(newCountriesData[indexPath.section].deaths.formatting()) \(differenceDeaths)"
        default:
            content.secondaryText = ""
        }
        
        cell.contentConfiguration = content
        StorageMyCountriesManager.shared.updateCountriesInfo()
        return cell
    }
}

extension MyCountriesTableViewController: HeaderViewDelegate {
    func expandedSection(button: UIButton) {
        let section = button.tag
        
        let isExpanded = expanded[section]
        expanded[section] = !isExpanded
        
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    
    func deleteSection(button: UIButton, section: Int) {
        
        StorageMyCountriesManager.shared.deleteCountry(section)
        
        oldCountriesData = StorageMyCountriesManager.shared.fetchCountryInfo()
        
        tableView.reloadData()
    }
    
    
}
