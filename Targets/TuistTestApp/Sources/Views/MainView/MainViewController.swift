//
//  MainViewController.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture
import RxDataSources


class MainViewController: SuperViewControllerSetting<MainViewModel> , AlertProtocol{
    
    //UI
    lazy var searchBar = DoneSearchBar().then{
        $0.placeholder = "검색어를 입력해주세요."
        $0.searchBarStyle = .minimal
        
        $0.searchTextField.layer.borderColor = UIColor.gray.cgColor
        $0.searchTextField.layer.cornerRadius = 10
        $0.searchTextField.layer.borderWidth = 1
        $0.searchTextField.largeContentImage?.withTintColor(.gray) // 왼쪽 돋보기 모양 커스텀
        $0.searchTextField.borderStyle = .none // 기본으로 있는 회색배경 없애줌
        $0.searchTextField.leftView?.tintColor = .gray
    }
    
    lazy var searchImageCollectionView : UICollectionView = {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.33)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = itemSize
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerElement.pinToVisibleBounds = true
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerElement]
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: compositionalLayout)
        collectionView.backgroundColor = .primaryColorReverse
        collectionView.indicatorStyle = .white
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
        collectionView.register(ImageCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ImageCellHeader.id)
        return collectionView
    }()
    
    var emptySearchView = UILabel().then{
        $0.text = "검색 결과가 없습니다.\n다른 검색어로 검색해보세요."
        $0.backgroundColor = .primaryColorReverse
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .placeholderText
        $0.isHidden = true
    }
    
   
    var typeSettingSheetView = SpotBottomSheetView()
    
    
    
    //DataSource
    lazy var imageSearchDataSource = RxCollectionViewSectionedReloadDataSource<ImageSearchSectionModel> { dataSource, collectionView , indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as! ImageCollectionViewCell
        cell.itemSetting(item: item)
        return cell
    }
    
    
    
    //Other
    private let sortTypeAction = PublishSubject<ImageSearchRequestModel.SortType>()
    
    var sectionHeaderTypeChangeDelegate : SectionHeaderTypeChangeDelegate?
    
    
    override func uiDrawing() {
        view.addSubview(searchBar)
        view.addSubview(searchImageCollectionView)
        view.addSubview(emptySearchView)
        view.addSubview(typeSettingSheetView)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        searchImageCollectionView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        emptySearchView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        typeSettingSheetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func uiSetting() {
        
        searchImageCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        
        imageSearchDataSource.configureSupplementaryView = { [weak self] (dataSource, collectionView, kind, indexPath) in
            guard let self = self else { return UICollectionReusableView() }
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ImageCellHeader.id, for: indexPath) as! ImageCellHeader
                self.sectionHeaderTypeChangeDelegate = headerView
                
                return headerView
            } else {
                return UICollectionReusableView()
            }
        }
    }
    
    override func viewModelBinding() {
        let searchAction = searchBar.rx.text
            .orEmpty
            .filter { $0 != "" }
            .asDriverOnErrorNever()
            //필수 조건 2번  UISearchBar에 문자를 입력 후 1초가 지나면 자동으로 검색이 됩니다.
            .debounce(.seconds(1))
            .distinctUntilChanged()
        
        let bottomScrollTriger = searchImageCollectionView.rx
            .reachedBottom(offset: 0)
            .asDriverOnErrorNever()
     
        let cellClick = searchImageCollectionView.rx.modelSelected(ImageSearchModel.self).asDriverOnErrorNever()
        
        typeSettingSheetView.sortTypeViewArray.forEach{ item in
            item.rx.tapGesture()
                .when(.recognized)
                .map{ _ in item.item }
                .subscribe(onNext: { [weak self] item in
                    guard let self = self else { return  }
                    self.typeSettingSheetView.hideBottomSheet()
                    self.sortTypeAction.onNext(item)
                })
                .disposed(by: disposeBag)
        }
        
        
        let output = viewModel.transform(input: .init(
            searchAction: searchAction ,
            bottomScrollTriger: bottomScrollTriger,
            cellClick: cellClick,
            sortTypeAction: sortTypeAction.asDriverOnErrorNever()
        ))
        
        
        output.imageSearchModels
            .drive(searchImageCollectionView.rx.items(dataSource: imageSearchDataSource))
            .disposed(by: disposeBag)

        output.imageSearchModels
            .map{ $0.first?.items.count != 0 }
            .drive(emptySearchView.rx.isHidden)
            .disposed(by: disposeBag)



        output.searchClear
            .drive{ [weak self] _ in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.searchImageCollectionView.setContentOffset(.zero, animated: true)
            }
            .disposed(by: disposeBag)

        output.outputError
            .drive(onNext: { [ weak self] value in
                guard let self = self else { return }
                
                self.showAlert(title: "오류", message: value.localizedDescription , preferredStyle: .alert )
                
            })
            .disposed(by: disposeBag)

        output.sortType
            .drive{ [weak self] item in
                guard let self = self else { return }
                self.typeSettingSheetView.sortTypeSetting(type: item)
            }
            .disposed(by: disposeBag)
        
        output.sortType
            .drive{ [weak self] item in
                guard let self = self else { return }
                self.sectionHeaderTypeChangeDelegate?.sortTypeAction(type: item)
            }
            .disposed(by: disposeBag)
        
        output.outputActivity
            .drive{ loading in
                if(loading){
                    LoadingView.show()
                }else{
                    LoadingView.hide()
                }
            }
           .disposed(by: disposeBag)
        
        
    }
    

}
extension MainViewController : UICollectionViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
 
}




