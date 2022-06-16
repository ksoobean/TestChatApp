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
        self.title = detailViewModel.naviTitle
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
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
        
        self.tableView.register(ChatDetailCell.self,
                                forCellReuseIdentifier: ChatDetailCell.identifier)
        
        // 테이블뷰 데이터
        self.detailViewModel.listData
            .bind(to: self.tableView.rx.items(cellIdentifier: ChatDetailCell.identifier,
                                              cellType: ChatDetailCell.self)) { row, cellVM, cell in
                cell.configureCell(with: cellVM)
            }.disposed(by: disposeBag)
        
        // 테이블뷰 셀 클릭 액션
        Observable
            .zip(tableView.rx.modelSelected(ChatDetailCellViewModel.self),
                 tableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (cellVM, indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                
            }).disposed(by: disposeBag)
        
    }

    
}

//MARK: - UITableViewDelegate
extension ChatDetailViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
