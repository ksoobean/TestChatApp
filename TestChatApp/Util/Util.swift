//
//  Util.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/16.
//

import Foundation

class Util {
    
    static let shared = Util()
    
    
    /// 사용자 이름
    private var _userName: String = ""
    var userName: String {
        set {
            _userName = newValue
        }
        
        get {
            return _userName
        }
    }
}
