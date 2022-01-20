//
//  Member.swift
//  TestMiOS
//
//  Created by FloreaIulian on 1/19/22.
//  Copyright © 2022 Adina Porea. All rights reserved.
//

import Foundation
import BDataProvider

struct Member {
    let memberId: String
    var developer: Developer
    var image: Data? = nil
    var imageDownloaded: Bool = false
    var encryptionKey: String? = nil
    var loadingEncription: Bool = false
}
