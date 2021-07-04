//
//  ViewController.swift
//  homeWork2.10
//
//  Created by Александра Мельникова on 26.06.2021.
//
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        self.countryTextField.delegate = self
        setTotalInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let countryInfoVC = segue.destination as? InfoViewController else { return }
        
        let country = countryTextField.text?.split(separator: " ").joined(separator: "%20").lowercased()
        
        guard country != "" else {
            countryInfoVC.countryName = "russia"
            return
        }
        
        countryInfoVC.countryName = country!
        countryTextField.text = ""
    }
}

// MARK: Setting of Total data

extension MainViewController {
    func setTotalInfo() {
        
        NetworkTotalInfoManager.shared.fetchTotalInfo() { totalInfo in
            
            DispatchQueue.main.async {
                
                var differenceConfirmed = ""
                var differenceDeaths = ""
                var differenceRecover = ""
                
                if let previosTotalInfo = StorageTotalInfoManager.shared.fetchTotalData() {
                    
                    differenceConfirmed = "(+\((Int(totalInfo.confirmed ?? 0) - Int(previosTotalInfo.confirmed ?? 0)).formatting()))"
                    differenceDeaths = "(+\((Int(totalInfo.deaths ?? 0) - Int(previosTotalInfo.deaths ?? 0)).formatting()))"
                    differenceRecover = "(+\((Int(totalInfo.recovered ?? 0) - Int(previosTotalInfo.recovered ?? 0)).formatting()))"
                }
                
                self.confirmedLabel.text = "\(totalInfo.confirmed?.formatting() ?? "0") \(differenceConfirmed)"
                self.deathsLabel.text = "\(totalInfo.deaths?.formatting() ?? "0") \(differenceDeaths)"
                self.recoveredLabel.text = "\(totalInfo.recovered?.formatting() ?? "0") \(differenceRecover)"
                
                StorageTotalInfoManager.shared.save(totalInfo: totalInfo)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: Keyboard settings

extension MainViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: .none)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
