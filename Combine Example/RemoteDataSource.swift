//
//  ViewModel.swift
//  Combine Example
//
//  Created by Md Shofiulla on 4/4/22.
//

import Foundation
import Combine
class RemoteDataSource{
    static let shared = RemoteDataSource()
    
    func fetchData() -> Future<[String], Error>{
        let dayList = ["Satuday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        return Future{
            result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                result(.success(dayList))
            }
        }
    }
}
