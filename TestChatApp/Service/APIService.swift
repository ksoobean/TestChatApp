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
