//
//  BluetoothHelper.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

import Foundation
import CoreBluetooth
import SwiftFlux

class BluetoothHelper: NSObject, CBPeripheralManagerDelegate {
    enum BluetoothStatus: Int {
        case PoweredOn = 0
        case PoweredOff
        case Unauthorized
        case Unsupported
        
        var description: String {
            switch self {
            case .PoweredOn: return "PoweredOn"
            case .PoweredOff: return "PoweredOff"
            case .Unauthorized: return "Unauthorized"
            case .Unsupported: return "Unsupported"
            }
        }
    }
    typealias Status = BluetoothStatus
    
    static let sharedInstance:BluetoothHelper = BluetoothHelper()
    private var manager:CBPeripheralManager?
    var state:CBPeripheralManagerState? // raw state
    var status:BluetoothStatus? // general state
    
    override init() {
        super.init()
    }
    
    func startListen() {
        if(manager == nil) {
            manager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        }
        self.manager?.delegate = self
    }
    
    func stopListen() {
        self.manager?.delegate = nil
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
//        print("[BluetoothHelper] \(__FUNCTION__)")
      
        self.state = peripheral.state
        
        switch(peripheral.state) {
        case .PoweredOn:
            print("[BluetoothHelper] PoweredOn Broadcasting...")
            status = BluetoothStatus.PoweredOn
            ActionCreator.invoke(DeviceStatusAction.UpdateBluetoothStatus(value: StatusPayload(value: true, status: status!.rawValue)))
            break
            
        case .PoweredOff:
            print("[BluetoothHelper] PoweredOff")
            status = BluetoothStatus.PoweredOff
            ActionCreator.invoke(DeviceStatusAction.UpdateBluetoothStatus(value: StatusPayload(value: false, status: status!.rawValue)))
            break
            
        case .Unauthorized:
            print("[BluetoothHelper] Unauthorized")
            status = BluetoothStatus.Unauthorized
            ActionCreator.invoke(DeviceStatusAction.UpdateBluetoothStatus(value: StatusPayload(value: false, status: status!.rawValue)))
            break
            
        case .Unsupported:
            print("[BluetoothHelper] Unsupported")
            status = BluetoothStatus.Unsupported
            ActionCreator.invoke(DeviceStatusAction.UpdateBluetoothStatus(value: StatusPayload(value: false, status: status!.rawValue)))
            break
            
        case .Unknown:
            print("[BluetoothHelper] Unknown")
            status = BluetoothStatus.Unsupported
            ActionCreator.invoke(DeviceStatusAction.UpdateBluetoothStatus(value: StatusPayload(value: false, status: status!.rawValue)))
            break
            
        case .Resetting:
            print("[BluetoothHelper] Resetting")
            status = BluetoothStatus.PoweredOff
            ActionCreator.invoke(DeviceStatusAction.UpdateBluetoothStatus(value: StatusPayload(value: false, status: status!.rawValue)))
            break
        }
    }
    
}
