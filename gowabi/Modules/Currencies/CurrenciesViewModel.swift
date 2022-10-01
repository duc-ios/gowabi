//
//  CurrenciesViewModel.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import RxAlamofire

class CurrenciesViewModel: BaseViewModel {
    
    // Actions
    
    let actionGetCurrencies = Action<Void, [Currency]> {
        RxAlamofire
            .data(.get, "https://mocki.io/v1/f9d357a3-25c8-4264-a36b-a805dba4a279")
            .debug()
            .observe(on: MainScheduler.instance)
            .map { (try JSONDecoder().decode(CurrenciesResponse.self, from: $0)).currencies }
            .do { debugPrint($0) }
    }
    
    // Variable
    
    let items = BehaviorRelay<[Currency]>(value: [])
    
    // Config
    
    override var actionErrors: [Observable<Error>] {
        [actionGetCurrencies.underlyingError]
    }
    
    override var actionExecuting: [Observable<Bool>] {
        [actionGetCurrencies.executing]
    }
    
    override func configActions() {
        super.configActions()
        
    }
    
    override func configSuccess() {
        super.configSuccess()
        
        actionGetCurrencies.elements.bind(to: items).disposed(by: rx.disposeBag)
    }
    
    override func configErrors() {
        super.configErrors()
        
    }
    
}
