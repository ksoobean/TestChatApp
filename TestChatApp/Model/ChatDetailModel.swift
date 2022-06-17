//
//  ChatDetailModel.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation

struct ChatDetailModel: Codable {
    
    /// 채팅방 구분을 위한 room ID
    let roomId: Int?
    
    /// 상대방 이름
    let name: String?
    /// 상대방의 직업
    let job: String?
    /// 상대방의 회사
    let company: String?
    
    /// 대화리스트
    let chatList: [ChatContentInfo]?
}

struct ChatContentInfo: Codable {
    
    /// 대화 작성자
    let writerName: String?
    /// 타임스탬프
    let timeStamp: Int?
    /// 대화 내용
    let content: String?
}
