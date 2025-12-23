//
//  Extensions.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 23/12/25.
//

import Foundation

extension Int? {
    var zeroUnWrapped: Int {
        return self ?? 0
    }
}

extension Double? {
    var zeroUnWrapped : Double {
        return self ?? 0.0
    }
}
