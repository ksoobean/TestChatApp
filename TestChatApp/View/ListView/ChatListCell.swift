//
//  ChatListCell.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import SnapKit
import RxSwift

class ChatListCell: UITableViewCell {
    
    static let identifier: String = "ChatListCell"
    
    private var cellVM: ChatViewModel!
    
    /// 이름
    private let nameLabel: UILabel = UILabel()
    /// 프로필 이미지
    private let profileImageView: UIImageView = UIImageView()
    /// 소속(직업 및 회사)
    private let descriptionLabel: UILabel = UILabel()
    /// 마지막 대화 날짜
    private let dateLabel: UILabel = UILabel()
    /// 가장 마지막 최근 대화
    private let recentChatLabel: UILabel = UILabel()
    /// 대화 카운트 배지
    private let unreadCountLabel: BadgeLabel = BadgeLabel()
    
    
    let disposeBag = DisposeBag()
    
    //MARK: - 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.text = nil
        
        self.profileImageView.alpha = 0
        self.profileImageView.image = nil
        
        self.descriptionLabel.text = nil
        
        self.dateLabel.text = nil
        
        self.recentChatLabel.text = nil
        
        self.unreadCountLabel.isHidden = true
        self.unreadCountLabel.text = nil
    }
    
    //MARK: - cell 데이터 셋팅함수
    
    /// cell 꾸며주는 함수
    /// - Parameters:
    ///   - cellVM: ChatViewModel
    public func configureCell(with cellVM: ChatViewModel) {
        self.cellVM = cellVM
        
        self.nameLabel.text = cellVM.name
        self.descriptionLabel.text = cellVM.jobDescription
        self.recentChatLabel.text = cellVM.recentChat
        self.dateLabel.text = cellVM.recentDate
        
        // 안읽음 카운트 배지 라벨 셋팅
        self.setUnreadCountLabel()
        
        self.requestAvatarImage(with: cellVM.profileURL)
            .observe(on: MainScheduler.instance)
            .subscribe { image in
                self.profileImageView.image = image
            } onCompleted: {
                UIView.animate(withDuration: 0.2) {
                    self.profileImageView.alpha = 1
                }
            }.disposed(by: disposeBag)

    }
    
    /// 안읽음 카운트 배지 셋팅
    private func setUnreadCountLabel() {
        
        guard cellVM.hasUnreadCount else {
            self.unreadCountLabel.isHidden = true
            return
        }
        
        self.unreadCountLabel.isHidden = false
        self.unreadCountLabel.text = cellVM.unreadCount
        self.unreadCountLabel.setRoundedCorner()
    }
    
    //MARK: - 아바타 URL로부터 이미지 데이터 생성하기
    
    /// 아바타 URL로부터 이미지 데이터 생성하기
    /// - Parameter urlString: avatar_url
    /// - Returns: Observable<UIImage>
    public func requestAvatarImage(with urlString: String) -> Observable<UIImage> {
        
        guard let url = URL(string: urlString),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
            return Observable.empty()
        }
        
        return Observable.just(image)
      }
}


//MARK: - UI Layout
extension ChatListCell {
    
    /// 하위 뷰 셋팅
    private func initView() {
        
        // 프로필 이미지뷰
        self.contentView.addSubview(profileImageView)
        
        self.profileImageView.layer.cornerRadius = 10
        self.profileImageView.clipsToBounds = true
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.profileImageView.alpha = 0
        self.profileImageView.contentMode = .scaleToFill
        
        // 이름 라벨
        self.contentView.addSubview(nameLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        
        // 소속 라벨
        self.contentView.addSubview(descriptionLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        
        // 최근 대화 라벨
        self.contentView.addSubview(recentChatLabel)
        
        recentChatLabel.font = UIFont.systemFont(ofSize: 18)
        recentChatLabel.textColor = .black
        recentChatLabel.numberOfLines = 1
        recentChatLabel.textAlignment = .left
        
        // 날짜 라벨
        self.contentView.addSubview(dateLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        
        // 안읽은 대화 카운트 라벨
        self.contentView.addSubview(unreadCountLabel)
        
        unreadCountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        unreadCountLabel.textColor = .white
        unreadCountLabel.textAlignment = .center
        unreadCountLabel.backgroundColor = .systemRed
        
        self.setConstraint()
    }
    
    /// 하위 뷰 레이아웃 셋팅
    private func setConstraint() {
        
        // 프로필 이미지뷰 레이아웃
        profileImageView.snp.remakeConstraints { make in
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        // 이름 라벨 레이아웃
        nameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.top.equalTo(profileImageView.snp.top)
        }
        
        // 날짜 라벨 레이아웃
        dateLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.width.equalTo(50)
            make.trailing.equalToSuperview().offset(-16).priority(.high)
        }
        
        // 소속 라벨 레이아웃
        descriptionLabel.snp.remakeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-30)
        }
        
        // 최근 대화 라벨 레이아웃
        recentChatLabel.snp.remakeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-30)
        }
        
        // 안읽음 카운트 라벨 레이아웃
        unreadCountLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(dateLabel.snp.trailing)
            make.centerY.equalTo(recentChatLabel.snp.centerY)
        }
        
    }
}
