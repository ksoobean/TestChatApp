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
    
    var naviTitle: String = ""
    var naviDescription: String = ""
    
    let disposeBag = DisposeBag()
    
    public var listData: BehaviorRelay<[ChatDetailCellViewModel]> = BehaviorRelay(value: [])
    
    init(roomId: Int) {
        self.requestChatDetail(with: roomId)
    }
    
    private func requestChatDetail(with roomId: Int) {
        self.naviTitle = "BBB"
        self.naviDescription = "iOS개발자 @회사회사회사이름"
        
        let testData: [ChatDetailCellViewModel] = [
            ChatDetailCellViewModel(content: ChatContentInfo(date: "2022-06-15", content: "안녕하세요.")),
            ChatDetailCellViewModel(content: ChatContentInfo(date: "2022-06-15", content: "아 죄송해요. 이제야 메세지를 봤습니다. 저도 반가웠습니다! 어떤 부탁인가요?")),
            ChatDetailCellViewModel(content: ChatContentInfo(date: "2022-06-15", content: "안녕하세요. 홍로켓님 잘 지내셨나요? 일전에 UX 세미나에서 반가웠습니다. 다름이 아니라 부탁드릴 것이 있어서 이렇게 연락드립니다."))
        ]
        
        self.listData.accept(testData)
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
        return chatContent.date ?? ""
    }
    
    var content: String {
        return chatContent.content ?? ""
    }
    
}
