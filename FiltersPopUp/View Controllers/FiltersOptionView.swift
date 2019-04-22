//
//  UIViewViewController.swift
//  iBusiness
//
//  Created by Nikos Menexis on 15/10/2018.
//  Copyright © 2018 Nikos Menexis. All rights reserved.
//

import UIKit

protocol FilterOptionProtocol{
    func openFiltersTapped()
}

class FiltersOptionView: UIView {

    var filterType = ""
    var delegate: FilterOptionProtocol?
    
    @IBOutlet weak var filterByLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    func changeFilter(filter:SortData){
        let firstAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        let firstString = NSMutableAttributedString(string: "Filter by: ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: filter.rawValue, attributes: secondAttributes)
       
        firstString.append(secondString)
        self.filterByLabel.attributedText = firstString
    }
    
    @IBAction func openFiltertapped(_ sender: Any) {
        self.delegate?.openFiltersTapped()
    }
    
    override init(frame: CGRect) {
        // Drawing code
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("FiltersOptionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
