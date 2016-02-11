//
//  DeviceStatusStore.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

import Foundation
import SwiftFlux
import Result

class DeviceStatusStore : Store {
    
    private var dispatchIdentifiers: Array<String> = []
    
    enum DeviceStatusEvent {
        case UpdateNetworkStatus
        case UpdateBluetoothStatus
    }
    typealias Event = DeviceStatusEvent
    
    let eventEmitter = EventEmitter<DeviceStatusStore>()
    
    private var _data:DeviceStatusData = DeviceStatusData()
    
    var data: DeviceStatusData {
        return _data
    }
    
    init() {
        dispatchIdentifiers.append(
            ActionCreator.dispatcher.register(DeviceStatusAction.UpdateNetworkStatus.self) { (result) in
                switch result {
                case .Success(let box):
                    self._data.isNetworkConnected = box.value
                    // emit change only
                    if(self._data.networkStatus != NetworkHelper.NetworkStatus(rawValue: box.status)) {
                        self._data.networkStatus = NetworkHelper.NetworkStatus(rawValue: box.status)
                        self.eventEmitter.emit(DeviceStatusEvent.UpdateNetworkStatus)
                    }
                case .Failure(_):
                    break;
                }
            }
        )
        
        dispatchIdentifiers.append(
            ActionCreator.dispatcher.register(DeviceStatusAction.UpdateBluetoothStatus.self) { (result) in
                switch result {
                case .Success(let box):
                    self._data.isBluetoothEnabled = box.value
                    // emit change only
                    if(self._data.bluetoothStatus != BluetoothHelper.BluetoothStatus(rawValue: box.status)) {
                        self._data.bluetoothStatus = BluetoothHelper.BluetoothStatus(rawValue: box.status)
                        self.eventEmitter.emit(DeviceStatusEvent.UpdateBluetoothStatus)
                    }
                case .Failure(_):
                    break;
                }
            }
        )
    }
    
    func unregister() {
        for identifier in dispatchIdentifiers {
            ActionCreator.dispatcher.unregister(identifier)
        }
    }
}