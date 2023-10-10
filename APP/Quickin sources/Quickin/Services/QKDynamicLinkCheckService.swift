//
//  QKDynamicLinkCheckService.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 26.10.2021.
//

import Foundation
import Firebase

final class DynamicLinkCheckService {
    
    static func isDynamicLink(_ url: URL) -> Bool {
        return DynamicLinks.dynamicLinks().handleUniversalLink(url) {(dynamicLink, error) in}
    }
    
//    static func getRoute(url: URL, completion: @escaping Closure1<DeepLinkRoute>){
//        DynamicLinks.dynamicLinks().handleUniversalLink(url) { (dynamicLink, error) in
//
//            guard error == nil,
//                  let dynamicLink = dynamicLink,
//                  let url = dynamicLink.url
//            else {
//                return
//            }
//            let marketplaceRoute = DeepLinkDestination.getMarketplaceRoute(url: url)
//            completion(marketplaceRoute)
//        }
//    }
    
    static func getFullUrl(url: URL) -> URL?{
        return DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)?.url
    }
    
    static func getDynamicLink(from urlStr: String) -> URL?{
        guard let url = URL(string: urlStr), DynamicLinkCheckService.isDynamicLink(url) else {
            return nil
        }
        return url
    }
}
