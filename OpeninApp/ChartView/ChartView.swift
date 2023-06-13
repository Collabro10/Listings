//
//  ChartView.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 13/06/23.
//

import UIKit
import SnapKit
import DGCharts
import Charts

protocol ChartInteractable {
    var presenter: ChartPresentable? { get }
    
    func viewDidLoad()
}

protocol ChartInterface: UIView {
    func populateChart(with schema: Schema?)
}

class ChartView: UIView {
    
    var interactor: ChartInteractable!
    
    
    let lineChart = LineChartView()
    
    let heading: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.text = "Overview"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lineChart.delegate = self
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        addSubview(lineChart)
        addSubview(heading)
        
        heading.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        lineChart.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(heading.snp.bottom).offset(4)
        }
    }
    
    func populateChart(with schema: Schema?) {
        guard let overallURLChart = schema?.data.overallURLChart else {
            return
        }
        
        var entries = [ChartDataEntry]()
        var labels = [String]()
        var previousMonth = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for (key, value) in overallURLChart.sorted(by: { $0.key < $1.key }) {
            if let date = dateFormatter.date(from: key) {
                let month = Calendar.current.component(.month, from: date)
                let monthName = dateFormatter.monthSymbols[month - 1]
                
                if monthName != previousMonth {
                    let label = "\(monthName)"
                    labels.append(label)
                    previousMonth = monthName
                } else {
                    let label = ""
                    labels.append(label)
                }
                
                let day = Calendar.current.component(.day, from: date)
                let entry = ChartDataEntry(x: Double(entries.count), y: Double(value))
                entries.append(entry)
            }
        }
        
        let set = LineChartDataSet(entries: entries)
        set.drawFilledEnabled = true
        set.fillColor = UIColor.blue
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        lineChart.xAxis.labelCount = labels.count
        lineChart.xAxis.granularity = 1
        lineChart.xAxis.labelPosition = .bottom
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.labelPosition = .outsideChart
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            interactor.viewDidLoad()
        }
    }
}

extension ChartView: ChartViewDelegate {
    
}

extension ChartView: ChartPresentable {
    
}

extension ChartView: ChartInterface {
    
}
