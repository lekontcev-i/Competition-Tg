//
//  QKQuickinPointModel+Karte.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import Foundation
import Karte

extension QKQuickinPointModel: LocationRepresentable {
    
    var address: String? {
        guard let pointAddress = pointAddress else { return nil }
        var result: String = ""
        
        if let cityName = pointAddress.cityName {
            result = cityName
        }
        
        if let street = pointAddress.street {
            if result.isEmpty {
                result = street
            } else {
                result += ", \(street)"
            }
            
            if let building = pointAddress.building {
                result += ", \(building)"
            }
        }
        
        return result
    }
}
