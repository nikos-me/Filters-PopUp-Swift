//
//  MainViewController.swift
//  FiltersPopUp
//
//  Created by Nikos Menexis on 22/04/2019.
//  Copyright © 2019 Nikos Menexis. All rights reserved.
//

import UIKit

struct Order{
    var product:String
    var deliveryDate:Double
    var price:Double
    var category:String
    var manucipacity:String
    var amount:Int
}

class MainViewController: UIViewController, FilterOptionProtocol, FiltersProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtersOptionView: FiltersOptionView!
    
    var currentFilter:SortData = SortData.deliveryDate
    var orders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up Views
        self.tableView.delegate = self
        self.tableView.dataSource = self
        filtersOptionView.delegate = self
        filtersOptionView.changeFilter(filter: self.currentFilter)
        
        generateData()
    }

    // Filters delegate methods
    func openFiltersTapped() {
        let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FiltersViewController") as! FiltersViewController
        filterVC.delegate = self
        filterVC.currentFilter = self.currentFilter
        self.present(filterVC, animated: true, completion: nil)
    }
    
    func filterChoosed(filter: SortData) {
        filtersOptionView.changeFilter(filter: filter)
        self.currentFilter = filter
        sortDealsData(filter: filter)
    }

}

// Handle sorting
extension MainViewController {
    
    // Sort the data
    func sortDealsData(filter:SortData){
        switch filter {
        case .deliveryDate:
            self.orders.sort(by: {$0.deliveryDate < $1.deliveryDate})
            
        case .totalPriceDis:
            self.orders.sort(by: {$0.price < $1.price})
            
        case .totalPriceDes:
            self.orders.sort(by: {$0.price > $1.price})
            
        case .amount:
            self.orders.sort(by: {$0.amount > $1.amount})
            
        case .category:
             self.orders.sort(by: {$0.category < $1.category})
            
        case .product:
            self.orders.sort(by: {$0.product < $1.product})
            
        case .manucipacity:
            self.orders.sort(by: {$0.manucipacity < $1.manucipacity})
            
        }
        
        self.tableView.reloadData()
    }
}

// MARK: - Table View methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrderCell else{return UITableViewCell()}
        cell.configureCell(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }

}

extension MainViewController{
    private func generateData(){
        
        self.orders = [
            
            Order(product: "MacBook Pro", deliveryDate: Date().add(component: .day, value: 1)!.timeIntervalSince1970, price: 2000.0, category: "Laptops", manucipacity: "Athens", amount: 3),
            Order(product: "iPhone Xs", deliveryDate: Date().add(component: .day, value: 3)!.timeIntervalSince1970, price: 1100.0, category: "Smartphones", manucipacity: "Thessaloniki", amount: 15),
            Order(product: "iPhone Xs Max", deliveryDate: Date().add(component: .day, value: 5)!.timeIntervalSince1970, price: 989.0, category: "Smartphones", manucipacity: "Thessaloniki", amount: 4),
            Order(product: "MacBook Pro 13'", deliveryDate: Date().add(component: .day, value: 7)!.timeIntervalSince1970, price: 1800.0, category: "Laptops", manucipacity: "Patra", amount: 7),
            Order(product: "iPhone 6s Plus", deliveryDate: Date().add(component: .day, value: 9)!.timeIntervalSince1970, price: 869.0, category: "Smartphones", manucipacity: "Thessaloniki", amount: 14),
            Order(product: "iPad Pro", deliveryDate: Date().add(component: .day, value: 11)!.timeIntervalSince1970, price: 1200.0, category: "Tablets", manucipacity: "Patra", amount: 12),
            Order(product: "iPad", deliveryDate: Date().add(component: .day, value: 13)!.timeIntervalSince1970, price: 653.0, category: "Tablets", manucipacity: "Thessaloniki", amount: 21),
            Order(product: "iPad Air", deliveryDate: Date().add(component: .day, value: 15)!.timeIntervalSince1970, price: 678.0, category: "Tablets", manucipacity: "Athens", amount: 5),
            Order(product: "iPad Air 2", deliveryDate: Date().add(component: .day, value: 1)!.timeIntervalSince1970, price: 867.0, category: "Tablets", manucipacity: "Thessaloniki", amount: 15),
            Order(product: "iPhone X", deliveryDate: Date().add(component: .day, value: 17)!.timeIntervalSince1970, price: 979.0, category: "Smartphones", manucipacity: "Athens", amount: 7),
            Order(product: "iPhone XR", deliveryDate: Date().add(component: .day, value: 19)!.timeIntervalSince1970, price: 1150.0, category: "Smartphones", manucipacity: "Thessaloniki", amount: 10),
            Order(product: "MacBook Pro 15'", deliveryDate: Date().add(component: .day, value: 21)!.timeIntervalSince1970, price: 2300.0, category: "Laptops", manucipacity: "Patra", amount: 3)
            
        ]
        
        tableView.reloadData()
    }
}

class OrderCell: UITableViewCell{
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var manucipacityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureCell(order:Order){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.productLabel.text = order.product
        self.manucipacityLabel.text = order.manucipacity
        self.categoryLabel.text = "Category: \(order.category)"
        self.deliveryDateLabel.text = "Delivery at: \(dateFormatter.string(from:Date(timeIntervalSince1970: order.deliveryDate)))"
        self.amountLabel.text = "Amount: \(order.amount)"
        self.priceLabel.text = "Price: \(order.price)"
        
    }
}

extension Date{
    func add(component: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
}
