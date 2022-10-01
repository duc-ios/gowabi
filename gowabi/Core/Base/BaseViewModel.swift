//
//  BaseViewModel.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class BaseViewModel: NSObject {
    var actionErrors: [Observable<Error>] { [] }
    var actionExecuting: [Observable<Bool>] { [] }
    
    let errorRelay = PublishRelay<String?>()
    let successRelay = PublishRelay<String?>()
    let executing = BehaviorRelay<Bool>(value: false)
    
    func configActions() {
        Observable.combineLatest(actionExecuting)
            .map { $0.contains(true) }
            .bind(to: executing)
            .disposed(by: rx.disposeBag)
    }
    
    func configSuccess() {
        successRelay
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { message in
                guard let message = message?.replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: " ")
                else { return }
                Alert.showSuccess(message)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func configErrors() {
        errorRelay
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { error in
                guard let error = error?.replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: " ")
                else { return }
                Alert.showError(error)
            })
            .disposed(by: rx.disposeBag)
        
        Observable.merge(actionErrors)
            .map { $0.localizedDescription }
            .bind(to: errorRelay)
            .disposed(by: rx.disposeBag)
    }
    
    override init() {
        super.init()
        configSuccess()
        configErrors()
        configActions()
    }
}
