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
                //위에있는 아이템들이 좀 더 로우 레벨임
                //프로바이더에서 UseCaseProvider을 제공
                ProviderAssembler(),
                //등록된 프로바이더에서 UseCase를 제공하는 Dependencies
                UseCaseAssembly(),
                //코디네이터에서 ViewModel , ViewController을 생성하기에 상단에 만들어줌
                CoordinatorAssembly(),
                //
                ViewModelAssembler(),
                //ViewModel을 변수로 받아 ViewController 을 생성하는 Assembler
                //ViewModel을 변수로 받는이유는 추후 수정을 할때 ViewModel에 필요한값들이 추가가 된다면
                //ViewControllerAssember의 해당 ViewController , ViewModelAssembler의 해당 ViewModel 그리고 호출하는곳 총 3곳에서 변경이 이뤄줘야하지만
                //ViewModel을 변수로 받는다면 ViewModelAssembler의 해당 ViewModel을 생상하는쪽 그리고 호출하는쪽 총 2곳에서만 변경이 이뤄지기에 ViewModel 자체를 변수로 받도록 처리
                ViewControllerAssembler()
            ],
            container: .init())
        return assembler
    }()
}

