//
//  DummyData.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import Foundation

final class DummyData {
    
    static let dummyData: [[String: Any]] = [
        [
            "description" : "МФЦ Василеостровского района",
            "schedule" : [
                "is_noctidial" : false,
                "sunday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ],
                "wednesday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ],
                "friday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ],
                "saturday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ],
                "tuesday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ],
                "thursday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ],
                "monday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:00"
                ]
            ],
            "friendly_schedule" : [
              "type" : "EVERY_DAY_SAME_TIME",
              "description" : "Ежедневно 9:00–21:00"
            ],
            "latitude" : 59.94374,
            "longitude" : 30.23310,
            "id" : "87007299-3997-4f8f-ac8d-9175b34a685c",
//            "payload_id" : "ABcd1209",
            "type" : [
              "description" : "МФЦ Василеостровского района",
              "name" : "МФЦ",
              "code" : "mfc"
            ],
            "address" : [
                "city_id" : "2",
                "street" : "ул. Нахимова",
                "city_name" : "Санкт-Петербург",
                "building" : "1 лит. А"
            ],
            "name" : "МФЦ"
        ],
        [
            "description" : "МФЦ Выборгского района",
            "schedule" : [
                "is_noctidial" : false,
                "saturday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ],
                "friday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ],
                "monday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ],
                "sunday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ],
                "wednesday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ],
                "thursday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ],
                "tuesday" : [
                    "is_workday" : true,
                    "end" : "21:00",
                    "start" : "9:30"
                ]
            ],
            "friendly_schedule" : [
              "description" : "Ежедневно 09:30–21:00",
              "type" : "EVERY_DAY_SAME_TIME"
            ],
            "latitude" : 60.05500,
            "longitude" : 30.36142,
            "id" : "d59b6729-a941-4895-b423-9f99250d7150",
//            "payload_id" : "ABcd1209",
            "type" : [
              "description" : "МФЦ Выборгского района",
              "name" : "МФЦ",
              "code" : "mfc"
            ],
            "address" : [
                "building" : "17, лит. А",
                "street" : "Придорожная аллея",
                "city_id" : "2",
                "city_name" : "Санкт-Петербург"
            ],
            "name" : "МФЦ"
        ],
        [
            "description" : "МФЦ Калининского района",
            "schedule" : [
                "is_noctidial" : false,
                "tuesday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "friday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "sunday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "thursday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "wednesday" : [
                    "end" : "21:00",
                    "start" : "09:00",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "description" : "Ежедневно 09:00–21:00",
              "type" : "EVERY_DAY_SAME_TIME"
            ],
            "latitude" : 59.96420,
            "longitude" : 30.38063,
            "id" : "e1825660-9db5-4db0-9712-213005217d48",
//            "payload_id" : "ABcd1209",
            "type" : [
              "name" : "МФЦ",
              "code" : "mfc",
              "description" : "МФЦ Калининского района"
            ],
            "address" : [
                "street" : "Кондратьевский пр.",
                "city_name" : "Санкт-Петербург",
                "building" : "22 лит. А",
                "city_id" : "2"
            ],
            "name" : "МФЦ"
        ],
        [
            "description" : "МФЦ Кировского района",
            "schedule" : [
                "is_noctidial" : false,
                "saturday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "thursday" : [
                    "end" : "17:00",
                    "start" : "09:30",
                    "is_workday" : true
                ],
                "sunday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "friday" : [
                    "end" : "16:00",
                    "start" : "09:30",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "17:00",
                    "start" : "09:30",
                    "is_workday" : true
                ],
                "wednesday" : [
                    "end" : "17:00",
                    "start" : "09:30",
                    "is_workday" : true
                ],
                "tuesday" : [
                    "end" : "17:00",
                    "start" : "09:30",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "type" : "CUSTOM_SCHEDULE"
            ],
            "latitude" : 59.83899,
            "longitude" : 30.27096,
            "id" : "2908cc9c-c725-474e-88b8-761cda590186",
//            "payload_id" : "ABcd1209",
            "type" : [
              "name" : "МФЦ",
              "code" : "mfc",
              "description" : "МФЦ Кировского района"
            ],
            "address" : [
                "city_name" : "Санкт-Петербург",
                "building" : "47",
                "city_id" : "2",
                "street" : "пр. Стачек"
            ],
            "name" : "МФЦ"
        ],
        
        
        
        [
            "description" : "Офис НефтьМагистраль",
            "schedule" : [
                "is_noctidial" : false,
                "thursday" : [
                    "end" : "19:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "19:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "sunday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "tuesday" : [
                    "end" : "19:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "friday" : [
                    "end" : "19:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "wednesday" : [
                    "end" : "19:00",
                    "start" : "09:00",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "type" : "ONLY_WEEKDAYS_SAME_TIME"
            ],
            "latitude" : 55.73344,
            "longitude" : 37.67134,
            "id" : "d7ad7a8a-c16e-47ae-91a1-45637bf56e98",
            "type" : [
              "name" : "Офис",
              "code" : "neftmagistral",
              "description" : "Офис НефтьМагистраль"
            ],
            "address" : [
                "building" : "26, строение 1",
                "city_id" : "1",
                "street" : "Волгоградский пр-т.",
                "city_name" : "Москва"
            ],
            "name" : "Офис"
        ],
        [
            "description" : "АЗС Нефтьмагистраль",
            "schedule" : [
                "is_noctidial" : true,
                "thursday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "tuesday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "sunday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "wednesday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "friday" : [
                    "end" : "21:00",
                    "start" : "10:00",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "description" : "Ежедневно 10:00–21:00",
              "type" : "EVERY_DAY_SAME_TIME"
            ],
            "latitude" : 55.98839,
            "longitude" : 37.72761,
            "id" : "5b63b0ab-7510-4f52-acca-14e748fc0313",
            "type" : [
              "name" : "АЗС",
              "code" : "neftmagistral",
              "description" : "АЗС Нефтьмагистраль"
            ],
            "address" : [
                "street" : "ул. Центральная",
                "city_name" : "д.Пирогово, М.О., Мытищи, Московская обл.",
                "building" : "д. 100а",
                "city_id" : "1"
            ],
            "name" : "АЗС"
        ],
        
        
        
        [
            "description" : "Mагазин Smart",
            "schedule" : [
                "is_noctidial" : false,
                "tuesday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "thursday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "sunday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "friday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "wednesday" : [
                    "end" : "20:00",
                    "start" : "09:00",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "type" : "EVERY_DAY_SAME_TIME"
            ],
            "latitude" : 56.23338,
            "longitude" : 43.43557,
            "id" : "8114fb1c-deef-4f70-bfaa-2530e95eb914",
            "type" : [
              "name" : "Smart",
              "code" : "smart",
              "description" : "Mагазин Smart"
            ],
            "address" : [
                "city_name" : "Дзержинськ, Нижньогородська обл.",
                "city_id" : "4",
                "building" : "61",
                "street" : "улица Гайдара"
            ],
            "name" : "Smart"
        ],
        
        
        
        
        [
            "description" : "Dom.Ru офис",
            "schedule" : [
                "is_noctidial" : false,
                "friday" : [
                    "end" : "18:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "thursday" : [
                    "end" : "18:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "sunday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "wednesday" : [
                    "end" : "18:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "tuesday" : [
                    "end" : "18:00",
                    "start" : "09:00",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "18:00",
                    "start" : "09:00",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "description" : "Ежедневно 09:00–20:30",
              "type" : "ONLY_WEEKDAYS_SAME_TIME"
            ],
            "latitude" : 55.74306,
            "longitude" : 37.63474,
            "id" : "cef7e830-7f0f-41de-9eae-a59811098b72",
            "type" : [
              "name" : "Dom.Ru",
              "code" : "domru",
              "description" : "Dom.Ru офис"
            ],
            "address" : [
                "city_name" : "Москва",
                "city_id" : "1",
                "street" : "Овчинниковская наб.",
                "building" : "20 стр. 2"
            ],
            "name" : "Dom.Ru"
        ],
        [
            "description" : "Dom.Ru офис",
            "schedule" : [
                "is_noctidial" : false,
                "friday" : [
                    "end" : "19:00",
                    "start" : "08:30",
                    "is_workday" : true
                ],
                "thursday" : [
                    "end" : "19:00",
                    "start" : "08:30",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "17:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "sunday" : [
                    "end" : "00:00",
                    "start" : "00:00",
                    "is_workday" : false
                ],
                "wednesday" : [
                    "end" : "19:00",
                    "start" : "08:30",
                    "is_workday" : true
                ],
                "tuesday" : [
                    "end" : "19:00",
                    "start" : "08:30",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "19:00",
                    "start" : "08:30",
                    "is_workday" : true
                ]
            ],
            "friendly_schedule" : [
              "type" : "ONLY_WEEKDAYS_SAME_TIME"
            ],
            "latitude" : 57.98865,
            "longitude" : 56.20972,
            "id" : "90351741-f1b5-4071-9e1a-004693227ca4",
            "type" : [
              "name" : "Dom.Ru",
              "code" : "domru",
              "description" : "Dom.Ru офис"
            ],
            "address" : [
                "city_name" : "Пермь, Пермский край",
                "building" : "д. 111, корп. 10",
                "street" : "шоссе Космонавтов",
                "city_id" : "3"
            ],
            "name" : "Dom.Ru"
        ],
        
        
        
        [
            "description" : "Ваш персональный ключ для авторизации в Wi-Fi сетях",
            "schedule" : [
                "is_noctidial" : true,
                "sunday" : [
                    "end" : "19:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "tuesday" : [
                    "end" : "19:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "monday" : [
                    "end" : "19:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "saturday" : [
                    "end" : "19:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "friday" : [
                    "end" : "19:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "wednesday" : [
                    "end" : "19:00",
                    "start" : "10:00",
                    "is_workday" : true
                ],
                "thursday" : [
                    "is_workday" : false
                ]
            ],
            "friendly_schedule" : [
              "type" : "EVERY_DAY_SAME_TIME"
            ],
            "latitude" : 56.01007,
            "longitude" : 37.72745,
            "id" : "181928bb-343c-4e9c-b209-ba85a2cd2989",
            "type" : [
              "name" : "Quickin",
              "code" : "quickin",
              "description" : "Ваш персональный ключ для авторизации в Wi-Fi сетях"
            ],
            "address" : [
                "building" : "19",
                "city_id" : "1",
                "street" : "Велосипедная улица",
                "city_name" : "д. Юдино, городской округ Мытищи, Московская обл."
            ],
            "name" : "Quickin"
        ]
    ]
    
}
