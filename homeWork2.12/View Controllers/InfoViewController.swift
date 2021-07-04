//
//  InfoViewController.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 26.06.2021.
//
import UIKit

class InfoViewController: UITableViewController {
    var countryName = ""
    var country = ""
    var confirmed = ""
    var recovered = ""
    var critical = ""
    var deaths = ""
    var code = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        setCountryInfo(countryName)
        
        let image = UIImage(named: "infoViewImage")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
    }
}

// MARK: Table View settings

extension InfoViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryInfoData.Titles.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = CountryInfoData.Titles.allCases[indexPath.row].rawValue
        content.textProperties.color = .black
        content.textProperties.font = UIFont (name: "Apple SD Gothic Neo", size: 16)!
        
        switch indexPath.row {
        case 0:
            content.secondaryText = "\(country)  \(GetFlag().getFlag(from: code))"
        case 1:
            content.secondaryText = confirmed
        case 2:
            content.secondaryText = recovered
        case 3:
            content.secondaryText = critical
        case 4:
            content.secondaryText = deaths
        default:
            content.secondaryText = ""
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: Setting of Country info

extension InfoViewController {
    func setCountryInfo(_ country: String) {
        
        NetworkCountryInfoManager.shared.fetchCountryInfo(country: country) { countryInfo in
            
            self.country = countryInfo.country
            self.confirmed = countryInfo.confirmed.formatting()
            self.recovered = countryInfo.recovered.formatting()
            self.critical = countryInfo.critical.formatting()
            self.deaths = countryInfo.deaths.formatting()
            self.code = countryInfo.code
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: Follow Button Functionality

extension InfoViewController {
    
    @IBAction func followButtonTapped(_ sender: UIBarButtonItem) {
        
        NetworkCountryInfoManager.shared.fetchCountryInfo(country: country) { countryInfo in
            StorageMyCountriesManager.shared.saveNewCountry(countryInfo: countryInfo)
        }
    }
}
