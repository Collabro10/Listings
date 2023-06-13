//
//  GreetingsInteractor.swift
//  OpeninApp
//
//  Created by Tushar Tiwary on 12/06/23.
//

import UIKit

protocol GreetingsPresentable: GreetingsInterface {
    var interactor: GreetingsInteractable! { get set }
    
    var greetingsLabel: UILabel { get }
}

final class GreetingsInteractor: GreetingsInteractable {
    
    weak var presenter: GreetingsPresentable?
    
    init(presenter: GreetingsPresentable) {
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        if let presenter = presenter {
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            
            if hour < 12 {
                presenter.greetingsLabel.text = "Good Morning"
            } else if hour < 18 {
                presenter.greetingsLabel.text = "Good Afternoon"
            } else {
                presenter.greetingsLabel.text = "Good Evening"
            }
        }
    }
}
