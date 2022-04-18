//
//  ViewControllerAssembler.swift
//  TuistTestApp
//
//  Created by 강지윤 on 2022/04/18.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Swinject
import UIKit

class ViewControllerAssembler : Assembly {
    func assemble(container: Container) {
        container.register(MainViewController.self) { (r , viewModel : MainViewModel) in
            let mainViewController : MainViewController = MainViewController(viewModel: viewModel)
            
            return mainViewController
        }
        
        container.register(DetailViewController.self) { (r , viewModel : DetailViewModel) in
            let detailViewModel : DetailViewController = DetailViewController(viewModel: viewModel)
            
            return detailViewModel
        }
    }
}
