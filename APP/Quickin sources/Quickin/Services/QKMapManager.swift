//
//  QKMapManager.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import UIKit
import YandexMapsMobile

protocol LocationPoint {
    var location: String { get }
    var id: Int { get }
}

protocol QKMapManagerDelegate: AnyObject {
    func didTapOnMap()
    func didUpdateMapCenter()
    func didSelectLocationPoint(point: LocationPoint)
}

protocol QKMapManager: AnyObject {
    var delegate: QKMapManagerDelegate? { get set }
    var selectedPoint: LocationPoint? { get }
    var currentLocation: YMKPoint { get set }
    var currentScreenCenterLocation: YMKPoint { get set }
    
    func initialSetup(with mapView: YMKMapView)
    func addPointsToCenter(points: [LocationPoint])
    func deselectPoint()
    
    func plusButtonDidTap()
    func minusButtonDidTap()
    func locationButtonDidTap()
    
    func removePlacemarks()
    
    func shiftCenterOnTop(mapHeight: Float)
    func moveCamera(to point: YMKPoint, duration: Float, completion: Closure?)
    
    func addPointDetailPin(pointLat: Float, pointLon: Float, mapHeight: Float)
}


class QKMapManagerImpl: NSObject, QKMapManager {
    
    var currentLocation: YMKPoint
    var currentScreenCenterLocation: YMKPoint
    
    weak var mapView: YMKMapView?
    
    weak var delegate: QKMapManagerDelegate?
    
    var currentPoints: [LocationPoint] = []
    var placemarks: [Int: YMKPlacemarkMapObject] = [:]
    var singlePointPlacemark: YMKPlacemarkMapObject?
    
    var selectedPoint: LocationPoint?
    var zoom: Float = 17
    
    var placemarkImage = UIImage(named: "ic_pointer") ?? UIImage()
    var selectedPlacemarkImage = UIImage(named: "ic_pointerSelected") ?? UIImage()
    
    init(latitude: Double, longitude: Double, zoom: Float = 17.0) {
        self.currentLocation = YMKPoint(latitude: latitude, longitude: longitude)
        self.currentScreenCenterLocation = YMKPoint(latitude: latitude, longitude: longitude)
        self.zoom = zoom
        
        let scale = UIScreen.main.scale
        placemarkImage = placemarkImage.resizeImage(targetSize: CGSize(width: 24 * scale, height: 24 * scale))
        selectedPlacemarkImage = selectedPlacemarkImage.resizeImage(targetSize: CGSize(width: 40 * scale, height: 40 * scale))
    }
    
    func initialSetup(with mapView: YMKMapView) {
        self.mapView = mapView
        
        setupListeners()
        setupMapCenter()
        setupUserPoint()
    }
    
    func setupMapCenter(animationDuration: Float = 0) {
        moveCamera(to: currentLocation, duration: animationDuration)
    }
    
    func setupZoomMapCenter(animationDuration: Float = 0) {
        guard let mapView = mapView else { return }
        
        let point = YMKPoint(
            latitude:  currentScreenCenterLocation.latitude,
            longitude: currentScreenCenterLocation.longitude
        )

        let currentPosition = YMKCameraPosition(
            target: point,
            zoom: zoom,
            azimuth: 0,
            tilt: 0
        )
        
        let animation = YMKAnimation(type: YMKAnimationType.smooth, duration: animationDuration)
        
        mapView.mapWindow.map.move(
            with: currentPosition,
            animationType: animation,
            cameraCallback: nil
        )
    }
    
    func setupUserPoint() {
        guard let mapView = mapView else { return }
        
        let userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.setObjectListenerWith(self)
    }
    
    func setupListeners() {
        guard let mapView = mapView else { return }
        let map = mapView.mapWindow.map
        
        map.addCameraListener(with: self)
        map.addInputListener(with: self)
    }
    
    func removePlacemarks() {
        guard let mapView = mapView else { return }
        let map = mapView.mapWindow.map
        placemarks.forEach { _, placemark in
             map.mapObjects.remove(with: placemark)
        }
        placemarks.removeAll()
        currentPoints.removeAll()
    }
    
    func addPointsToCenter(points: [LocationPoint]) {
        guard let mapView = mapView else { return }
        let map = mapView.mapWindow.map
        
        points.forEach { point in
            guard (currentPoints.filter{ $0.id == point.id }).count == 0 else { return }
            currentPoints.append(point)
            
            let posLat = Double(point.location.split(separator: ",")[0]) ?? 0
            let posLon = Double(point.location.split(separator: ",")[1]) ?? 0
            
            let placemark = map.mapObjects.addPlacemark(with: YMKPoint(latitude: posLat, longitude: posLon))
            placemark.opacity = 1
            placemark.setIconWith(placemarkImage)
            placemark.userData = point
            placemark.addTapListener(with: self)
            placemarks[point.id] = placemark
        }
        
        let xArr = placemarks.values.map { $0.geometry.latitude }.sorted()
        let yArr = placemarks.values.map { $0.geometry.longitude }.sorted()

        guard xArr.count != 0 else { return }

        let box = YMKBoundingBox.init(
            southWest: YMKPoint(latitude: (xArr.first ?? 0), longitude: (yArr.first ?? 0)),
            northEast: YMKPoint(latitude: (xArr.last ?? 0), longitude: (yArr.last ?? 0))
        )

        map.move(with: map.cameraPosition(with: box))
        let point = YMKPoint.init(
            latitude: map.cameraPosition.target.latitude,
            longitude: map.cameraPosition.target.longitude
        )
        let cameraPosition = YMKCameraPosition(
            target: point,
            zoom: map.cameraPosition.zoom - 0.2,
            azimuth: map.cameraPosition.azimuth,
            tilt: map.cameraPosition.tilt
        )
        map.move(with: cameraPosition)
    }
    
    func deselectPoint() {
        guard let point = selectedPoint else { return }
        guard let placemark = placemarks[point.id] else { return }
        
        selectedPoint = nil
        placemark.setIconWith(placemarkImage)
    }
    
    func addPointDetailPin(pointLat: Float, pointLon: Float, mapHeight: Float) {
        guard let mapView = mapView else { return }
        let map = mapView.mapWindow.map
        let mapWindow = mapView.mapWindow

        moveCamera(to: YMKPoint(latitude: Double(pointLat), longitude: Double(pointLon)))
        let point = YMKPoint(latitude: Double(pointLat), longitude: Double(pointLon))
        let screenCenterPosition = CGFloat(mapWindow?.worldToScreen(withWorldPoint: point)?.y ?? 0) / UIScreen.main.scale
        
        let delta = mapHeight * 0.325
        let newCenterInPixels = (screenCenterPosition + CGFloat(delta) + 16) * UIScreen.main.scale
        let newScreenPoint = YMKScreenPoint(
            x: Float(UIScreen.main.bounds.width * UIScreen.main.scale) / 2,
            y: Float(newCenterInPixels)
        )
        let newWorldCenter = mapWindow?.screenToWorld(with: newScreenPoint)
        
        moveCamera(to: newWorldCenter ?? YMKPoint(latitude: 0, longitude: 0))

        let placemarkPoint = YMKPoint(latitude: Double(pointLat), longitude: Double(pointLon))
        let placemark = map.mapObjects.addPlacemark(with: placemarkPoint)
        placemark.opacity = 1
        placemark.setIconWith(selectedPlacemarkImage)
        singlePointPlacemark = placemark
    }
    
    func shiftCenterOnTop(mapHeight: Float) {
        guard let mapView = mapView else { return }
        let mapWindow = mapView.mapWindow
        
        moveCamera(to: currentLocation)
        
        let newCenterInPixels = ((UIScreen.main.bounds.height - 48 - QKSafeArea.distance.topPadding) * 0.85) * UIScreen.main.scale
        let screenPoint = YMKScreenPoint(
            x: Float(UIScreen.main.bounds.width * UIScreen.main.scale) / 2,
            y: Float(newCenterInPixels)
        )
        let newWorldCenter = mapWindow?.screenToWorld(with: screenPoint)
        
        moveCamera(to: newWorldCenter ?? YMKPoint(latitude: 0, longitude: 0))
    }
    
    func moveCamera(to point: YMKPoint, duration: Float = 0, completion: Closure? = nil) {
        guard let mapView = mapView else { return }
        
        let point = YMKPoint(
            latitude:  point.latitude,
            longitude: point.longitude
        )
        let currentPosition = YMKCameraPosition(
            target: point,
            zoom: zoom,
            azimuth: 0,
            tilt: 0
        )
        
        let animationType = YMKAnimation(type: YMKAnimationType.smooth, duration: duration)
        
        mapView.mapWindow.map.move(
            with: currentPosition,
            animationType: animationType,
            cameraCallback: { finished in
                if finished {
                    completion?()
                }
            }
        )
    }
    
}
