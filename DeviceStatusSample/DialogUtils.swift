//
//  DialogUtils.swift
//  DeviceStatusSample
//
//  Created by Hui Key on 6/2/2016.
//  Copyright © 2016 KeyFun. All rights reserved.
//

import Foundation
import MBProgressHUD

class DialogUtils: NSObject {
    
    static let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    static let kDuration:NSTimeInterval = 2.0
    
    static func showText(text:String?, var duration:Double? = 0) {
        
        if(text == nil || text?.characters.count == 0) {
            return
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(appDelegate.window, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.detailsLabelText = text
        hud.detailsLabelFont = hud.labelFont
        hud.show(true)
        
        if(duration == 0) {
            duration = kDuration
        }
        hud.hide(true, afterDelay:duration!)
    }
    
    static func showText(view:UIView, text:String?, duration:NSTimeInterval) {
        if(text == nil || text?.characters.count == 0) {
            return
        }
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        //hud.labelText = text
        hud.detailsLabelText = text
        hud.detailsLabelFont = hud.labelFont
        hud.show(true)
        hud.hide(true, afterDelay:duration)
    }
    
    static func showLoading() {
        let hud = MBProgressHUD.showHUDAddedTo(appDelegate.window, animated: true)
        hud.mode = MBProgressHUDMode.Indeterminate
        hud.show(true)
    }
    
    static func hideLoading() {
        MBProgressHUD.hideHUDForView(appDelegate.window, animated: true)
    }
}