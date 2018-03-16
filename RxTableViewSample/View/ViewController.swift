//
//  ViewController.swift
//  RxTableViewSample
//
//  Created by 原野誉大 on 2018/03/15.
//  Copyright © 2018年 原野誉大. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class ViewController: UIViewController{
    

    let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewModel = ViewModel(
            input: (
                bannerTapped: collectionView.rx.modelSelected(Item.self).asObservable().debug("tap"),
                didScroll: collectionView.rx.didScroll.asSignal()
                )
                
        )
        
        // collectionView
        collectionView.register(UINib(nibName: String(describing: BannerCollectionViewCell.self), bundle:nil), forCellWithReuseIdentifier: "Cell")
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.items.bind(to: collectionView.rx.items(cellIdentifier: "Cell", cellType: BannerCollectionViewCell.self)) {  _, element, cell in
           cell.message.text = element.message
        }.disposed(by: disposeBag)

        viewModel.numberOfItems.bind(to: pageControl.rx.numberOfPages).disposed(by: disposeBag)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
