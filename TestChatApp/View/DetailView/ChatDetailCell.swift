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
    private let contentLabel: UILabel = UILabel()
    
    
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
        self.contentLabel.text = cellVM.content

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
        contentLabel.numberOfLines = 1
        contentLabel.textAlignment = .left
        
        self.setConstraint()
    }
    
    /// 하위 뷰 레이아웃 셋팅
    private func setConstraint() {
        
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
