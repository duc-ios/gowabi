//
//  Constants.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import UIKit

let keyWindow = UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .compactMap({$0 as? UIWindowScene})
    .first?.windows
.filter({$0.isKeyWindow}).first
