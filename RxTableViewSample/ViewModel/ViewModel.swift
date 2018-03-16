//
//  ViewModel.swift
//  RxTableViewSample
//
//  Created by 原野誉大 on 2018/03/15.
//  Copyright © 2018年 原野誉大. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    let model = Model()
    
    typealias Input = (
         bannerTapped: Observable<Item>,
        didScroll: Signal<Void>
    )
    
    
    let items : Observable<[Item]>
    let numberOfItems: Observable<Int>

    init(input:Input){
         items = model.getMessages()
        numberOfItems = items.map { $0.count }
        
        input.bannerTapped.subscribe(onNext:{ item in
           print(item.message)
        })
        
        
    }


    
}

