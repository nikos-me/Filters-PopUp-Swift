//
//  FiltersPopUp.swift
//  iBusiness
//
//  Created by Nikos Menexis on 22/10/2018.
//  Copyright © 2018 Nikos Menexis. All rights reserved.
//

import UIKit

enum SortData: String {
    case deliveryDate = "Delivery date"
    case totalPriceDes = "Total price (des)"
    case totalPriceDis = "Total price (dis)"
    case amount = "Amount"
    case manucipacity = "Manucipacity"
    case product = "Product"
    case category = "Category"
}

protocol FiltersProtocol {
    func filterChoosed(filter:SortData)
}

class FiltersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    var filtersArray = [SortData.deliveryDate,
                        SortData.totalPriceDes,
                        SortData.totalPriceDis,
                        SortData.product,
                        SortData.category,
                        SortData.amount,
                        SortData.manucipacity
    ]
    
    var delegate: FiltersProtocol?
    var currentFilter:SortData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func okTapped(_ sender: Any) {
        
        if let actualFilter = self.currentFilter{
            self.delegate?.filterChoosed(filter: actualFilter)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension FiltersViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell else{return UITableViewCell()}
        cell.filterName.text = filtersArray[indexPath.row].rawValue
        
        if currentFilter == self.filtersArray[indexPath.row]{
            cell.isSelected = true
        }else{
            cell.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.currentFilter = self.filtersArray[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
        tableView.reloadData()
    }
    
}

class FilterCell: UITableViewCell {
    @IBOutlet weak var filterName: UILabel!
    @IBOutlet weak var filterIcon: UIImageView!
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                
                UIView.animate(withDuration: 0.3) {
                    self.filterIcon.image = UIImage(named: "Box Filled")
                }
                
            }else{
                UIView.animate(withDuration: 0.3) {
                    self.filterIcon.image = UIImage(named: "Box Unchecked")
                }
            }
        }
    }
}
