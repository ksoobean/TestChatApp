//
//  ChatListModel.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation

struct ChatListModel: Codable {
    
    /// 채팅방 구분을 위한 room ID
    let roomId: Int?
    
    /// 이름
    let userName: String?
    /// 회사
    let company: String?
    /// 직업
    let job: String?
    /// 프로필 이미지 url
    let profileImageUrl: String?
    /// 최근 대화 내용
    let recentChat: String?
    /// 안읽은 메시지 카운트
    let unreadCount: Int?
    /// 최근 대화 날짜
    let lastChatDate: String?
}
