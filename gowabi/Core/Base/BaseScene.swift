//
//  BaseScene.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import UIKit

class BaseScene: UIViewController {
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        initUI()
        setupUI()
        binding()
    }
    
    func initUI() {}
    func setupUI() {}
    func binding() {}
}
