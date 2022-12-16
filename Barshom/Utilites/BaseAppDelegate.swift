//
//  ApplicationDelegate.swift
//  NBSFramework
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseAppDelegate: UIApplicationDelegate {
    var window: UIWindow? { get set }
    func reloadApp()
    var getAccessTokenURL: String { get set}
    var fontName: String { get set }
    var defaultLanguage: Language { get }

}
