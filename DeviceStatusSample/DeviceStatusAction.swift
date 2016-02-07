//
//  DeviceStatusAction.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

import Foundation
import SwiftFlux
import Result

class DeviceStatusAction {
    
    struct UpdateNetworkStatus: Action {
        typealias Payload = StatusPayload
        let value: StatusPayload
        
        func invoke(dispatcher: Dispatcher) {
            dispatcher.dispatch(self, result: Result(value: value))
        }
    }
    
    struct UpdateBluetoothStatus: Action {
        typealias Payload = StatusPayload
        let value: StatusPayload
        
        func invoke(dispatcher: Dispatcher) {
            dispatcher.dispatch(self, result: Result(value: value))
        }
    }
}