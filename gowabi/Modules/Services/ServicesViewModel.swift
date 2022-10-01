//
//  ServicesViewModel.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import RxAlamofire

class ServicesViewModel: BaseViewModel {
    internal init(currency: Currency) {
        self.currency = currency
    }
    
    // Actions
    
    let actionGetServices = Action<Void, [Service]> {
        RxAlamofire
            .data(.get, "https://mocki.io/v1/33bc2f87-f726-4b12-805a-11430dd3225d")
            .debug()
            .observe(on: MainScheduler.instance)
            .map { (try JSONDecoder().decode(ServiceResponse.self, from: $0)).services }
            .do { debugPrint($0) }
    }
    
    // Variable
    
    let currency: Currency
    let items = BehaviorRelay<[Service]>(value: [])
    
    // Config
    
    override var actionErrors: [Observable<Error>] {
        [actionGetServices.underlyingError]
    }
    
    override var actionExecuting: [Observable<Bool>] {
        [actionGetServices.executing]
    }
    
    override func configActions() {
        super.configActions()
        
    }
    
    override func configSuccess() {
        super.configSuccess()
        
        actionGetServices.elements.bind(to: items).disposed(by: rx.disposeBag)
    }
    
    override func configErrors() {
        super.configErrors()
        
    }
    
}
