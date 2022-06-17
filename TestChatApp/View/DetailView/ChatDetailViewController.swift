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

class ChatDetailViewController: UITableViewController {
    
    private var disposeBag = DisposeBag()
    let detailViewModel: DetailViewModel!
    
    init(detailVM: DetailViewModel) {
        self.detailViewModel = detailVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigation()
        self.configureTableView()
    }

    private func configureNavigation() {
        self.detailViewModel.naviTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // 오른쪽 새 메세지 버튼
        let newMessageButton = UIBarButtonItem(title: "새 메시지", style: .plain, target: self, action: #selector(newMessageAction))
        
        self.navigationItem.rightBarButtonItem = newMessageButton
    }
    
    /// 네비게이션 오른족 [새 메시지] 버튼 액션
    /// 새로운 채팅방 추가
    @objc func newMessageAction() {
        // 임시 테스트용
        // 채팅방 랜덤 생성
        
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomContent = (0..<20).map{ _ in str.randomElement()! }
        
        self.detailViewModel.sendChat(content: String(randomContent))
    }
    
    private func configureTableView() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
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

    
}
