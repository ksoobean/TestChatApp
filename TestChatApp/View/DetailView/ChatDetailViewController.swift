//
//  ChatDetailViewController.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ChatDetailViewController: UIViewController {
    
    private var tableView: UITableView = UITableView()
    private var inputBox: InputBox = InputBox()
    
    private var disposeBag = DisposeBag()
    let detailViewModel: DetailViewModel!
    
    init(detailVM: DetailViewModel) {
        self.detailViewModel = detailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 키보드 노티 등록
        self.registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 키보드 노티 제거
        self.unregisterForKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigation()
        
        self.configureUI()
        
    }

    private func configureNavigation() {
        self.detailViewModel.naviTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    
    private func configureUI() {
        
        self.view.addSubview(self.tableView)
        self.configureTableView()
        
        self.view.addSubview(inputBox)
        self.configureInputBox()
        
        
        self.setConstraint()
    }
    
    private func setConstraint() {
        
        self.tableView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        self.inputBox.snp.remakeConstraints { make in
            make.top.equalTo(self.tableView.snp.bottom)
            make.height.equalTo(80)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        
        self.tableView.register(ChatDetailCell.self,
                                forCellReuseIdentifier: ChatDetailCell.identifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        
        // 테이블뷰 데이터
        self.detailViewModel.listData
            .bind(to: self.tableView.rx.items(cellIdentifier: ChatDetailCell.identifier,
                                              cellType: ChatDetailCell.self)) { row, cellVM, cell in
                cell.configureCell(with: cellVM)
            }.disposed(by: disposeBag)
        
    }

    private func configureInputBox() {
        
        self.view.addSubview(inputBox)
        
        self.inputBox.delegate = self
    }
    
}

//MARK: - InputBoxProtocol
extension ChatDetailViewController: InputBoxProtocol {
    func sendMessage(with text: String) {
        
        self.detailViewModel.sendChat(content: text)
    }
    
    
}

//MARK: - 키보드 관련 로직.
extension ChatDetailViewController {
    
    /// 키보드 옵저버 등록
    func registerForKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow(noti:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide(noti:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    /// 키보드 옵저버 등록 해제
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    /// 키보드 보이기  처리
    @objc func keyboardShow(noti: NSNotification) {
        if noti.name == UIResponder.keyboardWillShowNotification,
           let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.inputBox.snp.updateConstraints { make in
                make.bottom.equalTo(CGFloat((-1) * Int(keyboardSize.height)))
            }
        }
    }
    
    /// 키보드 숨기기 처리
    @objc func keyboardHide(noti: NSNotification) {
        self.inputBox.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
        
    /// 화면 터치했을 때 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.inputBox.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
}
