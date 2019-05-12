//
//  URLSessionExt.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/10/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

//This protocol is created to allow easy mock URLSession
protocol DataSessionProtocol {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: DataSessionProtocol {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
}
