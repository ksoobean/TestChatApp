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
    
    /// 사용자 직업 정보
    private var _job: String = ""
    var userJob: String {
        set {
            _job = newValue
        }
        get {
            return _job
        }
    }
    
    /// 사용자 회사 정보
    private var _company: String = ""
    var company: String {
        set {
            _company = newValue
        }
        get {
            return _company
        }
    }
}
