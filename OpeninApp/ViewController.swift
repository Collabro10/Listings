//
//  TopLinksViewController.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 12/06/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var schema: Schema?
    
    let apiURl = "https://api.inopenapp.com/api/v1/dashboardNew"
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GreetingsCell.self, forCellReuseIdentifier: GreetingsCell.resueID)
        tableView.register(ChartViewCell.self, forCellReuseIdentifier: ChartViewCell.resusID)
        tableView.register(OpenInAppCell.self, forCellReuseIdentifier: OpenInAppCell.resueID)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let topLinksButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Top Links", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 14/255, green: 111/255, blue: 1, alpha: 1)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.layer.cornerRadius = 18
        btn.addTarget(self, action: #selector(topLinksButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    let recentLinksButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Recent Links", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.layer.cornerRadius = 18
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.addTarget(self, action: #selector(recentLinksButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        setupUI()
        fetchCardLinks(apiURL: apiURl, accessToken: accessToken) { result in
            switch result {
            case .success(let schema):
                print(schema)
                self.schema = schema
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
        
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func topLinksButtonTapped() {
        topLinksButton
            .backgroundColor = UIColor(red: 14/255, green: 111/255, blue: 1, alpha: 1)
        recentLinksButton.backgroundColor = .white
        topLinksButton.setTitleColor(.white, for: .normal)
        recentLinksButton.setTitleColor(.gray, for: .normal)
        tableView.reloadData()
    }
    
    @objc func recentLinksButtonTapped() {
        recentLinksButton
            .backgroundColor = UIColor(red: 14/255, green: 111/255, blue: 1, alpha: 1)
        topLinksButton.backgroundColor = .white
        recentLinksButton.setTitleColor(.white, for: .normal)
        topLinksButton.setTitleColor(.gray, for: .normal)
        tableView.reloadData()
    }
    
    func fetchCardLinks(apiURL: String, accessToken: String, completion: @escaping (Result<Schema, Error>) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])))
                return
            }
            
            do {
                let cardLinks = try JSONDecoder().decode(Schema.self, from: data)
                completion(.success(cardLinks))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 60
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            
            headerView.addSubview(topLinksButton)
            headerView.addSubview(recentLinksButton)
            
            topLinksButton.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.top.equalToSuperview().offset(16)
                make.width.equalTo(101)
            }
            
            recentLinksButton.snp.makeConstraints { make in
                make.left.equalTo(topLinksButton.snp.right).offset(24)
                make.centerY.equalTo(topLinksButton)
                make.width.equalTo(110)
            }
            
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116 + 20
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            if let count = schema?.data.topLinks.count {
                return count
            }
        } else {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GreetingsCell.resueID, for: indexPath) as! GreetingsCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OpenInAppCell.resueID, for: indexPath) as! OpenInAppCell
            if topLinksButton.backgroundColor == UIColor(red: 14/255, green: 111/255, blue: 1, alpha: 1) {
                if let topLinks = schema?.data.topLinks, indexPath.row < topLinks.count {
                    let topLink = topLinks[indexPath.row]
                    cell.setTitle(topLink.title)
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    if let createdAtDate = dateFormatter.date(from: topLink.createdAt) {
                        let outputDateFormatter = DateFormatter()
                        outputDateFormatter.dateFormat = "dd MMM yyyy"
                        let formattedDate = outputDateFormatter.string(from: createdAtDate)
                        cell.setDateLabel(formattedDate)
                    } else {
                        cell.setDateLabel("")
                    }
                    
                    
                    cell.setClicks(topLink.totalClicks)
                    cell.setWebLinks(topLink.webLink)
                    
                    let imageURLString = topLink.originalImage
                    let imageURL = URL(string: imageURLString)
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageURL!) {
                            DispatchQueue.main.async {
                                cell.setCardImage(UIImage(data: imageData))
                            }
                        }
                    }
                }
            } else if recentLinksButton.backgroundColor == UIColor(red: 14/255, green: 111/255, blue: 1, alpha: 1) {
                if let recentLinks = schema?.data.recentLinks, indexPath.row < recentLinks.count {
                    let recentLink = recentLinks[indexPath.row]
                    cell.setTitle(recentLink.title)
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    
                    if let createdAtDate = dateFormatter.date(from: recentLink.createdAt) {
                        let outputDateFormatter = DateFormatter()
                        outputDateFormatter.dateFormat = "dd MMM yyyy"
                        let formattedDate = outputDateFormatter.string(from: createdAtDate)
                        cell.setDateLabel(formattedDate)
                    } else {
                        cell.setDateLabel("")
                    }
                    
                    
                    cell.setClicks(recentLink.totalClicks)
                    cell.setWebLinks(recentLink.webLink)
                    
                    let imageURLString = recentLink.originalImage
                    let imageURL = URL(string: imageURLString)
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageURL!) {
                            DispatchQueue.main.async {
                                cell.setCardImage(UIImage(data: imageData))
                            }
                        }
                    }
                }
            }
            
            cell.frame.size.width = tableView.frame.width - 16
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChartViewCell.resusID, for: indexPath) as! ChartViewCell
            cell.populateChart(with: schema)
            return cell
        }
    }
}
