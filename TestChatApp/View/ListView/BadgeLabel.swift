//
//  BadgeLabel.swift
//  TestChatApp
//
//  Created by 김수빈 on 2022/06/15.
//

import Foundation
import UIKit

class BadgeLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let defaultSize = super.intrinsicContentSize
        return CGSize(width: defaultSize.width + 12, height: defaultSize.height + 8)
    }
    
    func setRoundedCorner() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.intrinsicContentSize.height / 2
    }
}
