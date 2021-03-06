//
//  APIService.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import RxSwift

class APIService {
    
    static let shared = APIService()
    
    //MARK: - 리스트 조회
    public func requestChatList() -> Observable<[ChatListModel]> {
        
        return Observable.just(Database.shared.loadChatRoomList())
        
    }
    
    //MARK: - 새로운 채팅방 만들기
    public func addNewChatRoom(with name: String, job: String, company: String, profileUrl: String) {
        Database.shared.addNewChatRoom(with: name, job: job, company: company, profileUrl: profileUrl)
        
    }
    
    
    //MARK: - 채팅방 상세 조회
    public func requestChatDetail(with roomId: Int) -> Observable<ChatDetailModel> {
        
        guard let detailInfo = Database.shared.loadChatDetailInfo(with: roomId) else {
            return Observable.empty()
        }
        
        return Observable.just(detailInfo)
    }
    
    //MARK: - 대화 보내기
    public func sendNewChat(to roomId: Int, content: String) {
        Database.shared.sendChat(to: roomId, content: content)
        
    }
    
    //MARK: - 프로필이미지 URL로부터 데이터 로드하기
    
    /// 프로필이미지 URL로부터 데이터 로드하기
    /// - Parameter urlString: profile url
    /// - Returns: Observable<UIImage>
    public func requestProfileImage(with urlString: String) -> Observable<UIImage> {
        
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return Observable.empty()
        }
        
        return Observable.just(image)
    }
}
