//
//  ViewController.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

import UIKit
import SwiftFlux

class ViewController: UIViewController {
    
    let deviceStatusStore = DeviceStatusStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.deviceStatusStore.eventEmitter.listen(DeviceStatusStore.Event.UpdateNetworkStatus) { () in
            print("isNetworkConnected = \(self.deviceStatusStore.data.isNetworkConnected)")
            print("networkStatus = \(self.deviceStatusStore.data.networkStatus?.description)")
            dispatch_async(dispatch_get_main_queue()) {
                DialogUtils.showText("isNetworkConnected = \(self.deviceStatusStore.data.isNetworkConnected)")
            }
        }
        
        self.deviceStatusStore.eventEmitter.listen(DeviceStatusStore.Event.UpdateBluetoothStatus) { () in
            print("isBluetoothEnabled = \(self.deviceStatusStore.data.isBluetoothEnabled)")
            print("bluetoothStatus = \(self.deviceStatusStore.data.bluetoothStatus?.description)")
            dispatch_async(dispatch_get_main_queue()) {
                DialogUtils.showText("isBluetoothEnabled = \(self.deviceStatusStore.data.isBluetoothEnabled)")
            }
        }
        
        NetworkHelper.sharedInstance.startListen()
        BluetoothHelper.sharedInstance.startListen()
    }
    
}

