//
//  DeviceStatusData.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

struct DeviceStatusData {
    var isNetworkConnected: Bool
    var isBluetoothEnabled: Bool
    var networkStatus: NetworkHelper.NetworkStatus?
    var bluetoothStatus: BluetoothHelper.BluetoothStatus?
    
    init() {
        isNetworkConnected = false
        isBluetoothEnabled = false
    }
}
