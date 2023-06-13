//
//  ChartViewCell.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 13/06/23.
//

import UIKit
import SnapKit

class ChartViewCell: UITableViewCell {
    
    static let resusID = "Chart"
    
    lazy var chartView: ChartInterface = {
        ChartBuilder().build()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func populateChart(with schema: Schema?) {
        chartView.populateChart(with: schema)
    }
}
