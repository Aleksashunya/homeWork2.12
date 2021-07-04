//
//  CustomHeaderView.swift
//  homeWork2.12
//
//  Created by Александра Мельникова on 04.07.2021.
//
import UIKit

protocol HeaderViewDelegate: AnyObject {
    func expandedSection(button: UIButton)
    func deleteSection(button: UIButton, section: Int)
}

class CustomHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: HeaderViewDelegate?
    
    @IBAction func headerButtonTapped(_ sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        
        delegate?.deleteSection(button: sender, section: section)
    }
}

extension CustomHeaderView {
    
    func configure(title: String, section: Int) {
        titleLabel.text = title
        headerButton.tag = section
        deleteButton.tag = section
    }
    
    func rotateImage(_ expanded: Bool) {
        if expanded {
            headerButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } else {
            headerButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
        }
    }
}
