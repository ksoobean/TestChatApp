//
//  InputBox.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/19.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

protocol InputBoxProtocol {
    func sendMessage(with text: String)
}

class InputBox: UIView {
    
    public var delegate: InputBoxProtocol?
    
    private var lineView: UIView = UIView()
    private var containerStackView: UIStackView = UIStackView()
    private var inputTextField: UITextField = UITextField()
    private var sendButton: UIButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.configureUI()
    }
    
    private func configureUI() {
        
        self.backgroundColor = .white
        
        // 구분선 추가
        lineView.backgroundColor = .gray
        self.addSubview(lineView)
        
        self.addSubview(containerStackView)
        
        containerStackView.alignment = .fill
        containerStackView.spacing = 5
        containerStackView.axis = .horizontal
        
        self.containerStackView.addArrangedSubview(inputTextField)
        
        inputTextField.text = ""
        inputTextField.textColor = .black
        inputTextField.placeholder = "메시지 입력"
        inputTextField.borderStyle = .none
        inputTextField.font = .systemFont(ofSize: 18)
        
        self.containerStackView.addArrangedSubview(sendButton)
        
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = .lightGray
        
        sendButton.rx.tap
            .bind {
                // 메시지 전송, 빈 문자열은 보내주지 않는다.
                guard let input = self.inputTextField.text, input != "" else {
                    return
                }
                self.delegate?.sendMessage(with: input)
                
                // 텍스트필드 비워주기
                self.inputTextField.text = ""
                
            }.disposed(by: disposeBag)
        
        
        self.setConstraint()
    }
    
    private func setConstraint() {
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.top.equalToSuperview()
        }
        
        containerStackView.snp.remakeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        sendButton.snp.remakeConstraints { make in
            make.width.equalTo(50)
        }
    }
    
}
