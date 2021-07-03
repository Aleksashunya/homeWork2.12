//
//  MyCountriesTableViewController.swift
//  homeWork2.12
//
//  Created by Александра Мельникова on 03.07.2021.
//

import UIKit

class MyCountriesTableViewController: UITableViewController {
    
    let oldCountriesData = StorageMyCountriesManager.shared.fetchCountryInfo()
    let newCountriesData = StorageMyCountriesManager.shared.getNewData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}

// MARK: Table View settings

extension MyCountriesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.oldCountriesData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryInfoData.Titles.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(GetFlag().getFlag(from: oldCountriesData[section].code)) \(oldCountriesData[section].country)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCountryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = CountryInfoData.Titles.allCases[indexPath.row].rawValue
        content.textProperties.color = .black
        content.textProperties.font = UIFont (name: "Apple SD Gothic Neo", size: 16)!
        
        let differenceConfirmed = newCountriesData[indexPath.section].confirmed - oldCountriesData[indexPath.section].confirmed
        let differenceRecovered = newCountriesData[indexPath.section].recovered - oldCountriesData[indexPath.section].recovered
        let differenceCritical = newCountriesData[indexPath.section].critical - oldCountriesData[indexPath.section].critical
        let differenceDeaths = newCountriesData[indexPath.section].deaths - oldCountriesData[indexPath.section].deaths
        
        switch indexPath.row {
        case 0:
            content.secondaryText = oldCountriesData[indexPath.section].country
        case 1:
            content.secondaryText = "\(newCountriesData[indexPath.section].confirmed.formatting()) (+\(differenceConfirmed.formatting()))"
        case 2:
            content.secondaryText = "\(newCountriesData[indexPath.section].recovered.formatting()) (+\(differenceRecovered.formatting()))"
        case 3:
            content.secondaryText = "\(newCountriesData[indexPath.section].critical.formatting()) (+\(differenceCritical.formatting()))"
        case 4:
            content.secondaryText = "\(newCountriesData[indexPath.section].deaths.formatting()) (+\(differenceDeaths.formatting()))"
        default:
            content.secondaryText = ""
        }
        
        cell.contentConfiguration = content
        StorageMyCountriesManager.shared.updateCountriesInfo()
        return cell
    }
}

//extension MyCountriesTableViewController {
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete {
//            StorageManager.shared.deleteContact(at: indexPath.row)
//            contacts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//}
