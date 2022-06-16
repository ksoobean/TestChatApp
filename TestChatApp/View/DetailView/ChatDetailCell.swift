//
//  ChatDetailCell.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ChatDetailCell: UITableViewCell {
    
    static let identifier: String = "ChatDetailCell"
    
    private var cellVM: ChatDetailCellViewModel!
    
    /// 날짜
    private let dateLabel: UILabel = UILabel()
    /// 대화내용
    private let contentLabel: PaddingLabel = PaddingLabel()
    
    
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
        
        self.dateLabel.text = nil
        self.contentLabel.text = nil
    }
    
    //MARK: - cell 데이터 셋팅함수
    
    /// cell 꾸며주는 함수
    /// - Parameters:
    ///   - cellVM: ChatViewModel
    public func configureCell(with cellVM: ChatDetailCellViewModel) {
        self.cellVM = cellVM
        
        self.dateLabel.text = cellVM.date
        
        self.setContentLabel()
    }
    
    private func setContentLabel() {
        
        self.contentLabel.text = cellVM.content
        self.contentLabel.setPadding(top: 10, bottom: 10, left: 10, right: 10)
        self.contentLabel.setRoundedCorner(with: 10)
    }
    
}


//MARK: - UI Layout
extension ChatDetailCell {
    
    /// 하위 뷰 셋팅
    private func initView() {
        
        // 날짜
        self.contentView.addSubview(dateLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .center
        
        // 대화 내용 라벨
        self.contentView.addSubview(contentLabel)
        
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0 // 여러줄 가능
        contentLabel.textAlignment = .left
        contentLabel.backgroundColor = .lightGray
        
        self.setConstraint()
    }
    
    /// 하위 뷰 레이아웃 셋팅
    private func setConstraint() {
        
        contentLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.greaterThanOrEqualTo(10)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(contentView.frame.width * 3/4) // 최대 너비 지정
        }
        
        dateLabel.snp.remakeConstraints { make in
            make.trailing.equalTo(contentLabel.snp.leading).offset(-16)
            make.bottom.equalTo(contentLabel.snp.bottom).offset(-8)
        }
        
//        // 날짜 라벨 레이아웃
//        dateLabel.snp.remakeConstraints { make in
//            make.centerY.equalTo(nameLabel.snp.centerY)
//            make.width.equalTo(50)
//            make.trailing.equalToSuperview().offset(-16).priority(.high)
//        }
//        
//        // 대화 내용 라벨 레이아웃
//        contentLabel.snp.remakeConstraints { make in
//            make.leading.equalTo(nameLabel.snp.leading)
//            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
//            make.trailing.equalTo(dateLabel.snp.leading).offset(-30)
//        }
        
    }
}
