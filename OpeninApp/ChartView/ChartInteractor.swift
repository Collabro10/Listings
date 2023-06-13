//
//  ChartInteractor.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 13/06/23.
//

import UIKit
import Charts
import DGCharts

protocol ChartPresentable: ChartInterface {
    var interactor: ChartInteractable! { get set }
    
}

final class ChartInteractor: ChartInteractable {
    
    weak var presenter: ChartPresentable?
    
    init(presenter: ChartPresentable) {
        self.presenter = presenter
    }
    
    func viewDidLoad() {

    }
}
