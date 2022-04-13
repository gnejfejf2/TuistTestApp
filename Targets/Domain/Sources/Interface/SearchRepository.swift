//
//  SearchRepository.swift
//  NetworkPlatform
//
//  Created by 강지윤 on 2022/04/13.
//  Copyright © 2022 JYKang. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchRepository {
    func getImageSearchModels(param : ImageSearchRequestModel) -> Single<ImageSearchResponseModel>
}
