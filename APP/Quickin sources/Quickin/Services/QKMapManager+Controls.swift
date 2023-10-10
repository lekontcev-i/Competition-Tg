//
//  QKMapManager+Controls.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit
import YandexMapsMobile

extension QKMapManagerImpl {
    
    func plusButtonDidTap() {
        zoom = (mapView?.mapWindow.map.cameraPosition.zoom ?? zoom) + 1
        setupZoomMapCenter(animationDuration: 0.3)
    }
    
    func minusButtonDidTap() {
        zoom = (mapView?.mapWindow.map.cameraPosition.zoom ?? zoom) - 1
        setupZoomMapCenter(animationDuration: 0.3)
    }
    
    func locationButtonDidTap() {
        setupMapCenter(animationDuration: 1)
    }
    
}
