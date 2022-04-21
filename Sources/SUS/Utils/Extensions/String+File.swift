//
//  String+File.swift
//  
//
//  Created by Łukasz Stachnik on 21/04/2022.
//

import Foundation

extension String {
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
