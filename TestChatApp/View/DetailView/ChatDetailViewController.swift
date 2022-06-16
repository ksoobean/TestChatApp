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
