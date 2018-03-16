//
//  Model.swift
//  RxTableViewSample
//
//  Created by 原野誉大 on 2018/03/16.
//  Copyright © 2018年 原野誉大. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class Model {
    let provider = MoyaProvider<API>(stubClosure: MoyaProvider.immediatelyStub)
    
    func getMessages() -> Observable<[Item]>{
       return provider.rx.request(.zen).debug("request")
        .map { response -> [Item] in
            return try! JSONDecoder().decode([Item].self, from: response.data)
        }.asObservable().share(replay: 1, scope: .forever).debug("message")
    }
}
