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
    
    public var listData: BehaviorRelay<[ChatCellViewModel]> = BehaviorRelay(value: [])
    
    init() {
        self.requestChatList()
    }
    
    /// 리스트 요청
    private func requestChatList() {
        APIService.shared.requestChatList()
            .map { chatList in
                chatList.map { ChatCellViewModel(chatModel: $0) }
            }
            .subscribe(onNext: { [weak self] value in
                self?.listData.accept(value)
            }).disposed(by: disposeBag)
    }
    
    public func addNewChatRoom(with name: String, job: String, company: String, profileUrl: String) {
        
        APIService.shared.addNewChatRoom(with: name, job: job, company: company, profileUrl: profileUrl)
        // 리스트 데이터 재조회
        self.requestChatList()
    }
}

/// 셀 뷰모델
struct ChatCellViewModel {
    
    private let chat: ChatListModel
    
    init(chatModel: ChatListModel) {
        self.chat = chatModel
    }
}

extension ChatCellViewModel {
    
    var roomId: Int {
        return chat.roomId ?? -1
    }
    
    var name: String {
        return chat.userName ?? ""
    }
    
    var profileURL: String {
        return chat.profileImageUrl ?? ""
    }
    
    var jobDescription: String {
        if let job: String = chat.job, let comp: String = chat.company {
            return "\(job)@\(comp)"
        }
        return ""
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
