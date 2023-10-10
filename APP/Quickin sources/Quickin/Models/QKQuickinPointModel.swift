//
//  QKQuickinPointModel.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import Foundation

struct QKQuickinPointModel: Codable {
    
    var id: String
    var payloadId: String?
    var pointAddress: QKQuickinPointAddess?
    var description: String?
    var latitude: Double
    var longitude: Double
    var name: String?
    var schedule: QKQuickinPointShedule?
    var friendlySchedule: QKQuickinPointFriendlySchedule
    var type: QKQuickinPointType
    
    enum CodingKeys: String, CodingKey {
        case id
        case payloadId = "payload_id"
        case pointAddress = "address"
        case friendlySchedule = "friendly_schedule"
        case description
        case latitude
        case longitude
        case name
        case schedule
        case type
    }

    // MARK: data calculations
    lazy var scheduleData: (day: String, time: String) = {
        guard let schedule = schedule else { return ("", "") }
        let daysList = schedule.daysList
        let newLine = "\n"
        
        switch friendlySchedule.type {
        case .EVERY_DAY_SAME_TIME:
            let dayShadule = daysList.first.map { schedule.scheduleForDay($0) } ?? ""
            return ("Ежедневно", dayShadule)
        case .ONLY_WEEKDAYS_SAME_TIME:
            let workTime = (schedule.scheduleForDay(schedule.monday)) + newLine +
                            (schedule.scheduleForDay(schedule.saturday)) + newLine +
                            (schedule.scheduleForDay(schedule.sunday))
            return ("Пн" + "-" + "Пт" + newLine +
                        "Сб" + newLine +
                        "Вс", workTime)
        case .CUSTOM_SCHEDULE:
            let daysNames = schedule.daysNames
            
            var daysShadule: [String] = []
            
            for i in 0..<daysList.count {
                let day = daysList[i]
                daysShadule.append(schedule.scheduleForDay(day))
            }
            
            return (daysNames.joined(separator: newLine), daysShadule.joined(separator: newLine))
        case .WEEKDAYS_SAME_AND_SATURDAY:
            let workTime = (schedule.scheduleForDay(schedule.monday)) + newLine + (schedule.scheduleForDay(schedule.sunday))
            return ("Пн" + "-" + "Сб" + newLine + "Вс", workTime)
        case .WEEKDAYS_SAME_AND_WEEKEND_SAME:
            let workTime = (schedule.scheduleForDay(schedule.monday)) + newLine + (schedule.scheduleForDay(schedule.saturday))
            return ("Пн" + "-" + "Пт" + newLine + "Сб" + "-" + "Вс", workTime)
        }
    }()

}

enum SheduleType: String, Codable {
    case EVERY_DAY_SAME_TIME
    case CUSTOM_SCHEDULE
    case ONLY_WEEKDAYS_SAME_TIME
    case WEEKDAYS_SAME_AND_SATURDAY
    case WEEKDAYS_SAME_AND_WEEKEND_SAME
}

struct QKQuickinPointAddess: Codable {
    var cityName: String?
    var building: String?
    var cityID: String
    var street: String?
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case building
        case cityID = "city_id"
        case street
    }
}

struct QKQuickinPointFriendlySchedule: Codable {
    var description: String?
    var type: SheduleType
}

struct QKQuickinPointShedule: Codable {
    var isNoctidial: Bool
    
    var monday: QKQuickinPointDayShedule
    var tuesday: QKQuickinPointDayShedule
    var wednesday: QKQuickinPointDayShedule
    var thursday: QKQuickinPointDayShedule
    var friday: QKQuickinPointDayShedule
    var saturday: QKQuickinPointDayShedule
    var sunday: QKQuickinPointDayShedule
    
    var daysList: [QKQuickinPointDayShedule] {
        return [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
    }
    
    var daysNames: [String] {
        return ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    }
    
    func scheduleForDay(_ day: QKQuickinPointDayShedule) -> String {
        return day.isWorkday ? "\(day.start ?? "") - \(day.end ?? "")" : "Выходной"
    }
    
    enum CodingKeys: String, CodingKey {
        case isNoctidial = "is_noctidial"
        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }
}

struct QKQuickinPointDayShedule: Codable {
    var isWorkday: Bool
    var start: String?
    var end: String?
    
    enum CodingKeys: String, CodingKey {
        case isWorkday = "is_workday"
        case start
        case end
    }
}

struct QKQuickinPointType: Codable {
    var code: QKQuickinPointCode
    var description: String?
    var name: String?
    
    enum QKQuickinPointCode: String, Codable {
        case smart
        case mfc
        case neftmagistral
        case domru
        case quickin
        case umico
    }
    
}

// MARK: fill
extension QKQuickinPointModel {
    
//    func pudoImages(completion: @escaping ([String]) -> ())  {
//        let maxImagesCount = 3
//        
//        var pudoImages: [String] = []
//        
//        let baseUrl: String
//        
//        #if DEV
//            baseUrl = "https://strgimgrsdev.umico.az"
//        #elseif STAGE
//            baseUrl = "https://strgimgrsstage.umico.az"
//        #elseif TEST
//            baseUrl = "https://strgimgrstest.umico.az"
//        #else
//            baseUrl = "https://strgimgr.umico.az"
//        #endif
//
//        let downloadGroup = DispatchGroup()
//        let concurrentQueue = DispatchQueue(label: "com.apply.chechPodoImagesUrls", attributes: .concurrent)
//        
//        let pathExtensions = ["jpg", "JPG"]
//        
//        concurrentQueue.async {
//            
//            for index in 1..<maxImagesCount+1 {
//                let url = "\(baseUrl)/pudo/\(id)/\(index)"
//                
//                if let imageURL = URL(string: url) {
//
//                    for pathExtension in pathExtensions {
//                        let fullUrl = imageURL.appendingPathExtension(pathExtension)
//                        
//                        downloadGroup.enter()
//                        URL.fileExistsAt(url: fullUrl) { (exists) in
//                            if exists {
//                                pudoImages.append(fullUrl.absoluteString)
//                            }
//                            downloadGroup.leave()
//                        }
//                    }
//                }
//            }
//            downloadGroup.notify(queue: DispatchQueue.main) {
//                completion(pudoImages)
//            }
//        }
//    }
    
    var infoAddressString: String {
        var addressComponents: [String] = []
        pointAddress?.cityName?.checkIsEmpty.map { addressComponents.append($0) }
        name?.checkIsEmpty.map { addressComponents.append($0) }
        pointAddress?.street?.checkIsEmpty.map { addressComponents.append($0) }
        pointAddress?.building?.checkIsEmpty.map { addressComponents.append($0) }
        
        return addressComponents.joined(separator: ", ")
    }
    
    var selectionAddressString: String {
        var addressComponents: [String] = []
        name?.checkIsEmpty.map { addressComponents.append($0) }
        pointAddress?.street?.checkIsEmpty.map { addressComponents.append($0) }
        pointAddress?.building?.checkIsEmpty.map { addressComponents.append($0) }
        return addressComponents.joined(separator: ", ")
    }
    
    var addressString: String {
        var addressComponents: [String] = []
        pointAddress?.cityName?.checkIsEmpty.map { addressComponents.append($0) }
        pointAddress?.street?.checkIsEmpty.map { addressComponents.append($0) }
        pointAddress?.building?.checkIsEmpty.map { addressComponents.append($0) }
        return addressComponents.joined(separator: ", ")
    }
    
//    var informerString: NSAttributedString {
//        let mutableSting = NSMutableAttributedString()
//        
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .center
//        
//        let title = (self.type.name ?? "").attributed([.font: Font.bold17, .foregroundColor: Color.Marketplace.titleBlack, .paragraphStyle: paragraphStyle])
//        
//        let bodyFont = Font.regular13
//        let bodyColor = Color.Marketplace.propertyBlack
//        
//        let newLine = Strings.General.newLine
//        let newLineAttributed = NSAttributedString(string: newLine + newLine, attributes: [.font: bodyFont])
//        
//        var subTitle: String?
//        var bodyString: NSAttributedString?
//        
//        let bulletColor = Color.Marketplace.discountRed
//        let source = Strings.Marketplace.Checkout.self
//        switch type.code {
//        case .serviceCenter:
//            subTitle = source.seviceCenterInfoTitle
//            let textsList = [source.seviceCenterInfoText0,
//                             source.seviceCenterInfoText1,
//                             source.seviceCenterInfoText2,
//                             source.seviceCenterInfoText3]
//            
//            bodyString = NSAttributedString.add(stringList: textsList,
//                                                font: bodyFont,
//                                                textColor: bodyColor,
//                                                bulletColor: bulletColor)
//        case .certifiedPoint:
//            subTitle = source.certifiedPointInfoSubtitle
//            let textsList = [source.certifiedPointInfoText0,
//                             source.certifiedPointInfoText1,
//                             source.certifiedPointInfoText2]
//            
//            bodyString = NSAttributedString.add(stringList: textsList,
//                                                font: bodyFont,
//                                                textColor: bodyColor,
//                                                bulletColor: bulletColor)
//        case .partnerPoint:
//            subTitle = source.partnerPointInfoSubtitle
//            
//        case .empty:
//            break
//        }
//
//        mutableSting.append(title)
//        mutableSting.append(newLineAttributed)
//        
//        if let subTitle = subTitle {
//            let pStyle = NSMutableParagraphStyle()
//            pStyle.alignment = .left
//            pStyle.lineBreakMode = .byWordWrapping
//            
//            let attributed = NSMutableAttributedString(string: subTitle, attributes: [.font: bodyFont, .foregroundColor: Color.Marketplace.propertyBlack, .paragraphStyle: pStyle])
//            mutableSting.append(attributed)
//            mutableSting.append(newLineAttributed)
//        }
//        
//        bodyString.map { mutableSting.append($0) }
//        
//        return mutableSting
//    }

    
}
