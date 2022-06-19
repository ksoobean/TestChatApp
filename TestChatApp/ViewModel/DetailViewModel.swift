//
//  DetailViewModel.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    var naviTitle: BehaviorRelay<String> = BehaviorRelay(value: "")
    var naviDescription: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    private let roomId: Int
    
    let disposeBag = DisposeBag()
    
    public var listData: BehaviorRelay<[ChatDetailCellViewModel]> = BehaviorRelay(value: [])
    
    init(roomId: Int) {
        self.roomId = roomId
        self.requestChatDetail()
    }
    
    /// 채팅룸 상세 정보 조회
    private func requestChatDetail() {
        
        APIService.shared.requestChatDetail(with: self.roomId)
            .subscribe(onNext: { [weak self] model in
                
                self?.naviTitle.accept(model.name ?? "")
                if let job = model.job, let comp = model.company {
                    self?.naviDescription.accept("\(job)@\(comp)")
                }
                
                if let chatList = model.chatList {
                    self?.listData.accept(chatList.map({ content in
                        ChatDetailCellViewModel(content: content)
                    }))
                } else {
                    self?.listData.accept([])
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    public func sendChat(content: String) {
        APIService.shared.sendNewChat(to: self.roomId, content: content)
        self.requestChatDetail()
    }
}


/// 셀 뷰모델
struct ChatDetailCellViewModel {
    
    private let chatContent: ChatContentInfo
    
    init(content: ChatContentInfo) {
        self.chatContent = content
    }
}

extension ChatDetailCellViewModel {
    
    var date: String {
        let date = Date(timeIntervalSince1970: chatContent.timeStamp ?? 0)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "HH:mm"

        let kr = formatter.string(from: date)
        
        return "\(kr)"
    }
    
    var content: String {
        return chatContent.content ?? ""
    }
    
    var isMyChat: Bool {
        return chatContent.writerName == Util.shared.userName
    }
}
