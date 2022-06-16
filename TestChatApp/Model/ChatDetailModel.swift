//
//  ChatDetailModel.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation

struct ChatDetailModel: Codable {
    
    /// 이름
    let name: String?
    /// 소속
    let jobDescription: String?
    /// 대화리스트
    let chatList: [ChatContentInfo]?
}

struct ChatContentInfo: Codable {
    
    /// 대화 작성자
    let writerName: String?
    /// 대화 날짜
    let date: String?
    /// 대화 내용
    let content: String?
}
