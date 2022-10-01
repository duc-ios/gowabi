//
//  ServicesScene.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation

import UIKit
import Stevia

class ServicesScene: BaseScene, BindableType {
    
    // MARK: - View models
    
    var viewModel: ServicesViewModel!
    
    // MARK: - Views
    
    let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Data
    
    // MARK: - Life Cycles
    
    override func initUI() {
        super.initUI()
        
        title = "Services"
        view.subviews(tableView)
        tableView.fillContainer()
    }
    
    override func binding() {
        super.binding()
        
        viewModel
            .items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { [weak self] _, item, cell in
                guard let self = self else { return }
                cell.textLabel?.text = item.formattedName(currency: self.viewModel.currency)
            }.disposed(by: rx.disposeBag)
        
        tableView
            .rx
            .itemSelected
            .bind { [weak self] in
                guard let self = self else { return }
                self.tableView.deselectRow(at: $0, animated: true)
                guard let item: Service = try? self.tableView.rx.model(at: $0) else { return }
                self.viewModel.successRelay.accept(item.formattedName(currency: self.viewModel.currency))
            }
            .disposed(by: rx.disposeBag)
        
        viewModel.actionGetServices.execute()
    }
    
}
