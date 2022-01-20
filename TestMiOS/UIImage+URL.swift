//
//  UIImage+URL.swift
//  TestMiOS
//
//  Created by FloreaIulian on 1/19/22.
//  Copyright © 2022 Adina Porea. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    static func fromUrl(_ urlString: String?, completion: @escaping (_ imageData: Data?) -> Void) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
                  completion(nil)
                  return
              }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { /// execute on main thread
                completion(data)
            }
        }
        
        task.resume()
    }
}
