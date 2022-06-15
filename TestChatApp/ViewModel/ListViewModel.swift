//
//  ListViewModel.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import RxSwift
import RxCocoa

/// 리스트 뷰모델
class ListViewModel {
    
    let naviTitle: String = "메시지"
    
    let disposeBag = DisposeBag()
    
    public var listData: BehaviorRelay<[ChatViewModel]> = BehaviorRelay(value: [])
    
    init() {
        self.requestChatList()
    }
    
    private func requestChatList() {
        let testData: [ChatViewModel] = [
            ChatViewModel(chatModel: ChatListModel(userName: "BBB", jobDescription: "iOS개발자 @회사회사회사이름", profileImageUrl: "https://source.unsplash.com/user/c_v_r", recentChat: "가장 최근 대화입니다. 어떻게 표시되나 확인차 길게 써봅니다.", unreadCount: 999, lastChatDate: "어제")), ChatViewModel(chatModel: ChatListModel(userName: "CCcCCCCCCC", jobDescription: "iOS개발자 @회사회사회사이름이름이름", profileImageUrl: "https://source.unsplash.com/user/c_v_r", recentChat: "가장 최근 대화입니다. ", unreadCount: 12, lastChatDate: "3일전")), ChatViewModel(chatModel: ChatListModel(userName: "AAAa", jobDescription: "iOS개발자 @회사회사회사이름이름이름", profileImageUrl: "https://source.unsplash.com/user/c_v_r", recentChat: "안읽음카운트 없음 ", unreadCount: 0, lastChatDate: "2022.05.12"))
            
        ]
        
        self.listData.accept(testData)
    }
}

/// 셀 뷰모델
struct ChatViewModel {
    
    let chat: ChatListModel
    
    init(chatModel: ChatListModel) {
        self.chat = chatModel
    }
}

extension ChatViewModel {
    
    var name: String {
        return chat.userName ?? ""
    }
    
    var profileURL: String {
        return chat.profileImageUrl ?? ""
    }
    
    var jobDescription: String {
        return chat.jobDescription ?? ""
    }
    
    var recentChat: String {
        return chat.recentChat ?? ""
    }
    
    var hasUnreadCount: Bool {
        return chat.unreadCount ?? 0 > 0
    }
    
    var unreadCount: String {
        if let count = chat.unreadCount {
            return count > 99 ? "99+" : "\(count)"
        }
        return "0"
    }
    
    var recentDate: String {
        return chat.lastChatDate ?? ""
    }
}
