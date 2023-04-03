//
//  String.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 27/03/23.
//

import Foundation

extension String{
    private var markdownDict: [String:String]{
        get{
            var dict : [String:String] = [:]
            dict["<b>"] = "**"
            dict["<i>"] = "*"
            dict["[x]"] = ""
            dict["[X]"] = ""
            return dict
        }
    }
    
    mutating func translateMarkdown(){
        for (key,value) in markdownDict{
            let endKey = key.replacingOccurrences(of: "<", with: "</")
            self.replace(key, with: value)
            self.replace(endKey, with: value)
        }
    }
    
}
