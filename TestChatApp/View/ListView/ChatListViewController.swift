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
        // 임시 테스트용
        // 채팅방 랜덤 생성
        
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomName = (0..<5).map{ _ in str.randomElement()! }
        let randomJob = (0..<5).map{ _ in str.randomElement()! }
        let randomCompany = (0..<5).map{ _ in str.randomElement()! }
        
        
        self.listViewModel.addNewChatRoom(with: String(randomName),
                                          job: String(randomJob),
                                          company: String(randomCompany),
                                          profileUrl: "https://source.unsplash.com/user/c_v_r")
    }
    
    private func configureTableView() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.register(ChatListCell.self,
                                forCellReuseIdentifier: ChatListCell.identifier)
        
        // 테이블뷰 데이터
        self.listViewModel.listData
            .bind(to: self.tableView.rx.items(cellIdentifier: ChatListCell.identifier,
                                              cellType: ChatListCell.self)) { row, cellVM, cell in
                cell.configureCell(with: cellVM)
            }.disposed(by: disposeBag)
        
        // 테이블뷰 셀 클릭 액션
        Observable
            .zip(tableView.rx.modelSelected(ChatCellViewModel.self),
                 tableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (cellVM, indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                
                guard -1 != cellVM.roomId else {
                    // roomID가 없는 경우 상세뷰 로드 X
                    return
                }
                
                let detailVC = ChatDetailViewController(detailVM: DetailViewModel(roomId: cellVM.roomId))
                self?.navigationController?.pushViewController(detailVC, animated: true)
                
            }).disposed(by: disposeBag)
        
    }

    
}

//MARK: - UITableViewDelegate
extension ChatListViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
