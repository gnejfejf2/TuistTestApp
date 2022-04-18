//
//  Assembler.swift
//  TuistTestApp
//
//  Created by 강지윤 on 2022/04/03.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Swinject

extension Assembler {
    static let shared: Assembler = {
        let assembler = Assembler(
            [
                ProviderAssembler(),
                UseCaseAssembly(),
               
              
                //위에있는 아이템들이 좀 더 로우 레벨임
                CoordinatorAssembly(),
                ViewModelAssembler()
            ],
            container: .init())
        return assembler
    }()
}

