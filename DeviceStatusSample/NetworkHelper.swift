//
//  NetworkHelper.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

import Foundation
import ReachabilitySwift
import SwiftFlux

class NetworkHelper: NSObject {
    enum NetworkStatus: Int {
        case ReachableViaWiFi = 0
        case ReachableViaCellular
        case NotReachable
        
        var description: String {
            switch self {
            case .ReachableViaWiFi: return "ReachableViaWiFi"
            case .ReachableViaCellular: return "ReachableViaCellular"
            case .NotReachable: return "NotReachable"
            }
        }
    }
    typealias Status = NetworkStatus
    
    static let sharedInstance:NetworkHelper = NetworkHelper()
    private var reachability: Reachability?
    
    var status:NetworkStatus?
    
    private var isStarted:Bool = false
    
    override init() {
        super.init()
        
        do {
            self.reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("[NetworkHelper] Unable to create Reachability")
            return
        }
    }
    
    func startListen() {
        if(isStarted) {
            return;
        }
        isStarted = true
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "reachabilityChanged:",
            name: ReachabilityChangedNotification,
            object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("[NetworkHelper] Unable to start notifier")
        }
    }
    
    func stopListen() {
        isStarted = false
        reachability?.stopNotifier()
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: ReachabilityChangedNotification,
            object: reachability)
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("[NetworkHelper] Reachable via WiFi")
                status = NetworkStatus.ReachableViaWiFi
                ActionCreator.invoke(DeviceStatusAction.UpdateNetworkStatus(value: StatusPayload(value: true, status: status!.rawValue)))
            } else {
                print("[NetworkHelper] Reachable via Cellular")
                status = NetworkStatus.ReachableViaCellular
                ActionCreator.invoke(DeviceStatusAction.UpdateNetworkStatus(value: StatusPayload(value: true, status: status!.rawValue)))
            }
        } else {
            print("[NetworkHelper] Not reachable")
            status = NetworkStatus.NotReachable
            ActionCreator.invoke(DeviceStatusAction.UpdateNetworkStatus(value: StatusPayload(value: false, status: status!.rawValue)))
        }
    }
    
    
//    func otherlistenMethod() {
//        reachability?.whenReachable = { reachability in
//            dispatch_async(dispatch_get_main_queue()) {
//                if reachability.isReachableViaWiFi() {
//                    print("Reachable via WiFi")
//                } else {
//                    print("Reachable via Cellular")
//                }
//            }
//        }
//        
//        reachability?.whenUnreachable = { reachability in
//            dispatch_async(dispatch_get_main_queue()) {
//                print("Not reachable")
//            }
//        }
//    }
}
