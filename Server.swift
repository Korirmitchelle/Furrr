//
//  Server.swift
//  Furr
//
//  Created by Mitch on 24/02/2020.
//  Copyright © 2020 Mitrch. All rights reserved.
//

import Foundation

class Server{
    func doSomething(completion:((String?,Int,NSError?) -> Void)?){
        DispatchQueue.global().async {
            DispatchQueue.concurrentPerform(iterations: 3) { index in
                self.startLoad(index: index, completion: completion)
            }
        }
    }
    
    func startLoad(index:Int,completion:((String?,Int,NSError?) -> Void)?) {
        guard let url = websiteLink else{return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion?(nil,index,error as NSError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion?(nil,index,nil)
                    return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "text/html",
                let data = data,
                let string = String(data: data, encoding: .utf8) {
                self.parseData(index: index, string: string, completion: completion)
            }
        }
        task.resume()
    }
    
    func parseData(index:Int,string:String,completion:((String?,Int,NSError?) -> Void)?){
        switch index {
        case 0:
            getHundredth(index: index, string: string, completion: completion)
        case 1:
            getEvery(index: index, string: string, separation: 10, completion: completion)
        default:
            getCount(index: index, string: string, completion: completion)
        }
    }
    
    func getHundredth(index:Int,string:String,completion:((String?,Int,NSError?) -> Void)?){
        let hundredth = string.index(string.startIndex, offsetBy: 99)
        let hundredthString = String(string[hundredth])
        completion?(hundredthString,index,nil)
    }
    
    func getEvery(index:Int,string:String,separation:Int,completion:((String?,Int,NSError?) -> Void)?){
        let everyTenth = string.separate(every: separation, with: "*")
        let splitArray = everyTenth.split(separator: "*")
        for word in splitArray{
            guard let character = word.last else{return}
            completion?(String(character),index,nil)
        }
    }
    
    func getCount(index:Int,string:String,completion:((String?,Int,NSError?) -> Void)?){
        let wordsArray = string.split(separator: " ")
        for word in wordsArray{
            let count = String(word.count)
            completion?(count,index,nil)
        }
    }
    
    
}


