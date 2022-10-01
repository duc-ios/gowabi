//
//  String+.swift
//  gowabi
//
//  Created by Duc on 01/10/2022.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { self }
}
