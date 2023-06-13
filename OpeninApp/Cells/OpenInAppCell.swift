//
//  OpenInAppCell.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 12/06/23.
//

import UIKit

class OpenInAppCell: UITableViewCell {
    
    static let resueID = "CellId"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let cardImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = .gray
        return img
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    
    let clicksLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return l
    }()
    
    let clicksText: UILabel = {
        let l = UILabel()
        l.text = "Clicks"
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    
    let webLinkLabel: UILabel = {
        let l = UILabel()
        l.textColor = .blue
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return l
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 8
        v.backgroundColor = .white
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.gray.cgColor
        return v
    }()
    
    let linkContainer: UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 8
        v.layer.borderColor = UIColor(red: 166/255, green: 199/255, blue: 255/255, alpha: 1).cgColor
        v.backgroundColor = UIColor(red: 166/255, green: 199/255, blue: 255/255, alpha: 1)
        return v
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(116)
        }
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(cardImage)
        containerView.addSubview(dateLabel)
        containerView.addSubview(clicksLabel)
        containerView.addSubview(clicksText)
        containerView.addSubview(linkContainer)
        linkContainer.addSubview(webLinkLabel)
        
        linkContainer.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        cardImage.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(cardImage.snp.right).offset(12)
            make.top.equalToSuperview().offset(14)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(cardImage.snp.right).offset(12)
        }
        
        clicksLabel.snp.makeConstraints { make in
            make.centerX.equalTo(clicksText)
            make.top.equalToSuperview().offset(14)
        }
        
        clicksText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-12)
        }
        
        webLinkLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(14.5)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setCardImage(_ image: UIImage?) {
        cardImage.image = image
    }
    
    func setDateLabel(_ text: String) {
        dateLabel.text = text
    }
    
    func setClicks(_ text: Int) {
        clicksLabel.text = "\(text)"
    }
    
    func setWebLinks(_ text: String) {
        webLinkLabel.text = text
    }
    
}
