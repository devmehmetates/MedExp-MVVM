//
//  Double + Ext.swift
//  SwiftUI-MVVM-Example
//
//  Created by Mehmet Ateş on 3.11.2022.
//

import SwiftUI

extension Double {
    var responsizeW: Double { return UIScreen.main.bounds.size.width * self / 100 }
    var responsizeH: Double { return UIScreen.main.bounds.size.height * self / 100 }
}
