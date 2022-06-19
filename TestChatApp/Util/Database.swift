//
//  Database.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/17.
//

import Foundation
import RxSwift
import RxRelay

struct ChatRoomTotalInfo: Codable {
    let roomId: Int
    let name: String
    let job: String
    let profileUrl: String
    let recentChat: ChatContentInfo
    let chatContent: [ChatContentInfo]
}

class Database {
    
    let ROOM_LIST_KEY: String = "RoomListKey"
    
    static let shared = Database()
    
    /// 새로운 채팅방 추가
    public func addNewChatRoom(with name: String, job: String, company: String, profileUrl: String) {
        
        // 새로운 채팅방 생성하고 추가해주기
        var list = self.loadChatRoomList()
        let newRoomId: Int = Int.random(in: 1...9999)
        list.append(ChatListModel(roomId: newRoomId, userName: name, company: company, job: job, profileImageUrl: profileUrl, recentChat: "", unreadCount: 0, lastChatDate: ""))
        
        self.setChatRoomList(with: list)
        
        // 채팅방 상세정보 추가해주기
        self.addNewChatDetailInfo(with: newRoomId, name: name, job: job, company: company)
        
    }
    
    /// 채팅방 리스트 로드
    public func loadChatRoomList() -> [ChatListModel] {
        if let data = UserDefaults.standard.data(forKey: ROOM_LIST_KEY) {
            let info = try! JSONDecoder().decode([ChatListModel].self, from: data)
            return info
        }
        return []
    }
    
    /// UserDefaults 채팅방 리스트 데이터 셋팅
    private func setChatRoomList(with newList: [ChatListModel]) {
        if let encoded = try? JSONEncoder().encode(newList) {
            UserDefaults.standard.set(encoded, forKey: ROOM_LIST_KEY)
        }
        
    }
    
    /// 새로운 채팅방 상세정보 추가
    public func addNewChatDetailInfo(with roomId: Int, name: String, job: String, company: String) {
        self.setChatDetailInfo(with: ChatDetailModel(roomId: roomId, name: name, job: job, company: company,  chatList: []))
    }
    
    /// 새로운 채팅 보냄
    public func sendChat(to roomId: Int, content: String) {
        let findChatDetail = self.loadChatDetailInfo(with: roomId)
        var newChatList = findChatDetail?.chatList
        // 테스트를 위해 상대방과 자기자신 중 랜덤으로 작성자 셋팅
        newChatList?.append(ChatContentInfo(writerName: [Util.shared.userName, findChatDetail?.name].randomElement()!,
                                            timeStamp: Date().timeIntervalSince1970,
                                            content: content))
        
        self.setChatDetailInfo(with: ChatDetailModel(roomId: roomId,
                                                     name: findChatDetail?.name,
                                                     job: findChatDetail?.job,
                                                     company: findChatDetail?.company,
                                                     chatList: newChatList))
    }
    
    /// 채팅방 상세정보 로드
    public func loadChatDetailInfo(with roomId: Int) -> ChatDetailModel? {
        if let data = UserDefaults.standard.data(forKey: "\(roomId)") {
            let info = try! JSONDecoder().decode(ChatDetailModel.self, from: data)
            return info
        }
        return nil
    }
    
    /// UserDefaults 채팅방 상세정보 데이터 셋팅
    private func setChatDetailInfo(with newInfo: ChatDetailModel) {
        if let roomId: Int = newInfo.roomId,
           let encoded = try? JSONEncoder().encode(newInfo) {
            UserDefaults.standard.set(encoded, forKey: "\(roomId)")
        }
            
    }
    

//    /// UserDefaults에 저장되어있는지 체크
//    public func checkUserisSaved(user: User) -> Bool {
//        let currentList = self.load().value
//        return currentList.contains(where: { $0.login == user.login })
//    }
    
    
}
