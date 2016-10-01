//
//  PagingMenuControllerOptions.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 6/9/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import Foundation
import PagingMenuController


struct PagingMenuOptions1: PagingMenuControllerCustomizable {
    
    var controllers:Array<UIViewController> = Array<UIViewController>()
    var menuOptions:MenuViewCustomizable
    var componentType: ComponentType {
        return .All(menuOptions:menuOptions, pagingControllers: controllers)
    }
}