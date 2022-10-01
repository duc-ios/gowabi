//
//  BindableType.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation
import UIKit

protocol BindableType where Self: UIResponder {
    associatedtype ViewModelType: BaseViewModel
    var viewModel: ViewModelType! { get set }
}

extension BindableType {
    func bind(_ viewModel: Self.ViewModelType) -> Self {
        self.viewModel = viewModel
        return self
    }
}
