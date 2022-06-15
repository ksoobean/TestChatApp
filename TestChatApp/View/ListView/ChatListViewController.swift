//
//  ViewController.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import UIKit
import RxSwift

class ChatListViewController: UITableViewController {
    
    private var disposeBag = DisposeBag()
    private let listViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.configureNavigation()
        self.configureTableView()
    }

    private func configureNavigation() {
        self.title = listViewModel.naviTitle
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // 오른쪽 새 메세지 버튼
        let newMessageButton = UIBarButtonItem(title: "새 메시지", style: .plain, target: self, action: #selector(newMessageAction))
        
        self.navigationItem.rightBarButtonItem = newMessageButton
    }
    
    /// 네비게이션 오른족 [새 메시지] 버튼 액션
    /// 새로운 채팅방 추가
    @objc func newMessageAction() {
        
    }
    
    private func configureTableView() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.register(ChatListCell.self,
                                forCellReuseIdentifier: ChatListCell.identifier)
        
        self.listViewModel.listData
            .bind(to: self.tableView.rx.items(cellIdentifier: ChatListCell.identifier,
                                              cellType: ChatListCell.self)) { row, chat, cell in
                cell.configureCell(with: chat)
            }.disposed(by: disposeBag)
    }

    
}

//MARK: - UITableViewDelegate
extension ChatListViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
