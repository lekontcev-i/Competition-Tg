//
//  QKMapManager+Listeners.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit
import YandexMapsMobile

extension QKMapManagerImpl: YMKMapObjectTapListener {
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let point = mapObject.userData as? LocationPoint else { return false }
        
        if selectedPoint != nil {
            guard let selectedPoint = selectedPoint else { return true }
            guard point.id != selectedPoint.id else { return false }
        }
        
        placemarks.forEach { _, placemark in
            placemark.setIconWith(placemarkImage)
        }
        
        let placemark = placemarks[point.id]
        let style = YMKIconStyle(
            anchor: CGPoint(x: 0.5, y: 0.9) as NSValue,
            rotationType: nil,
            zIndex: nil,
            flat: nil,
            visible: nil,
            scale: nil,
            tappableArea: nil
        )
        placemark?.setIconWith(selectedPlacemarkImage, style: style)
        
        selectedPoint = point
        delegate?.didSelectLocationPoint(point: point)
        
        return true
    }
}

extension QKMapManagerImpl: YMKMapCameraListener {
    
    func onCameraPositionChanged(
        with map: YMKMap,
        cameraPosition: YMKCameraPosition,
        cameraUpdateReason: YMKCameraUpdateReason,
        finished: Bool
    ) {
        guard finished else { return }
        guard let mapView = mapView else { return }
        
        let region = mapView.mapWindow.focusRegion
        
        let center = intersectionOfLines(line1: (a: CGPoint(x: Double(region.topLeft.latitude), y: Double(region.topLeft.longitude)),
                                                 b: CGPoint(x: Double(region.bottomRight.latitude), y: Double(region.bottomRight.longitude))),
                                         line2: (a: CGPoint(x: Double(region.topRight.latitude), y: Double(region.topRight.longitude)),
                                                 b: CGPoint(x: Double(region.bottomLeft.latitude), y: Double(region.bottomLeft.longitude))))
        
        self.currentScreenCenterLocation = YMKPoint(
            latitude:  Double(center.x),
            longitude: Double(center.y)
        )
        if cameraUpdateReason == .gestures {
            delegate?.didUpdateMapCenter()
        }
    }
    
    func intersectionOfLines(line1: (a: CGPoint, b: CGPoint), line2: (a: CGPoint, b: CGPoint)) -> CGPoint {
        let distance = (line1.b.x - line1.a.x) * (line2.b.y - line2.a.y) - (line1.b.y - line1.a.y) * (line2.b.x - line2.a.x)
        
        let u = ((line2.a.x - line1.a.x) * (line2.b.y - line2.a.y) - (line2.a.y - line1.a.y) * (line2.b.x - line2.a.x)) / distance
        
        return CGPoint(x: Double(line1.a.x + u * (line1.b.x - line1.a.x)),
                       y: Double(line1.a.y + u * (line1.b.y - line1.a.y)))
    }
}

extension QKMapManagerImpl: YMKUserLocationObjectListener {
    
    func onObjectAdded(with view: YMKUserLocationView) {
        view.accuracyCircle.fillColor = UIColor(red: 0.36, green: 0.59, blue: 0.93, alpha: 0.25)
        view.pin.setIconWith(UIImage(named: "userCenter") ?? UIImage())
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) { }
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) { }
}

extension QKMapManagerImpl: YMKMapInputListener {
    
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        delegate?.didTapOnMap()
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) { }
}
