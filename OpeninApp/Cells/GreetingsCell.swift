//
//  GreetingsCell.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 12/06/23.
//

import UIKit
import SnapKit

class GreetingsCell: UITableViewCell {
    
    static let resueID = "CellId1"
    
    lazy var greetingsView: GreetingsInterface = {
        GreetingsBuilder().build()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(greetingsView)
        
        greetingsView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
}
