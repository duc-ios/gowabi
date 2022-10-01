//
//  CurrenciesScene.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import UIKit
import Stevia

class CurrenciesScene: BaseScene, BindableType {
    
    // MARK: - View models
    
    var viewModel: CurrenciesViewModel!
    
    // MARK: - Views
    
    let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Data
    
    // MARK: - Life Cycles
    override func initUI() {
        super.initUI()
        
        title = "Please select a currency"
        view.subviews(tableView)
        tableView.fillContainer()
    }
    
    override func binding() {
        super.binding()
        
        viewModel
            .items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { _, item, cell in
                cell.textLabel?.text = item.label
            }.disposed(by: rx.disposeBag)
        
        tableView
            .rx
            .itemSelected
            .bind { [weak self] in
                self?.tableView.deselectRow(at: $0, animated: true)
                guard let item: Currency = try? self?.tableView.rx.model(at: $0) else { return }
                self?.navigationController?.pushViewController(ServicesScene().bind(ServicesViewModel(currency: item)), animated: true)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel.actionGetCurrencies.execute()
    }
}
