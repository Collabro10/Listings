//
//  GreetingsView.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 12/06/23.
//

import UIKit
import SnapKit

protocol GreetingsInteractable {
    var presenter: GreetingsPresentable? { get }
    
    func viewDidLoad()
}


protocol GreetingsInterface: UIView {
    
}

class GreetingsView: UIView {
    var interactor: GreetingsInteractable!
    
    let greetingsLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return l
    }()
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.text = "Tushar Tiwary"
        l.adjustsFontSizeToFitWidth = true
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return l
    }()
    
    let handImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "hand")
        return img
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(greetingsLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(handImage)
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(90)
        }
        
        greetingsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingsLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
        }
        
        handImage.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.top.equalTo(greetingsLabel.snp.bottom).offset(6)
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            interactor.viewDidLoad()
        }
    }
}

// MARK: Presenter Conformations
extension GreetingsView: GreetingsPresentable {
    
}


// MARK: Interface Conformations
extension GreetingsView: GreetingsInterface {
    
}
