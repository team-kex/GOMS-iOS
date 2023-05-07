//
//  OutingViewController.swift
//  GOMS-iOS
//
//  Created by 선민재 on 2023/04/18.
//

import UIKit
import Then
import SnapKit
import RxSwift

class OutingViewController: BaseViewController<OutingViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem()
        self.navigationItem.leftLogoImage()
        outingCollectionView.dataSource = self
        outingCollectionView.delegate = self
        outingCollectionView.register(
            OutingCollectionViewCell.self,
            forCellWithReuseIdentifier: OutingCollectionViewCell.identifier
        )
        outingCollectionView.collectionViewLayout = layout
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = OutingViewModel.Input(
            profileButtonTap: navigationItem.rightBarButtonItem!.rx.tap.asObservable()
        )
        viewModel.transVC(input: input)
    }
    
    private let outingMainText = UILabel().then {
        $0.text = "외출현황"
        $0.numberOfLines = 3
        $0.font = UIFont.GOMSFont(
            size: 24,
            family: .Bold
        )
        $0.textColor = .black
    }
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.itemSize = CGSize(
            width: (
                (UIScreen.main.bounds.width) - 52
            ),
            height: (
                90
            )
        )
        $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0) //아이템 상하좌우 사이값 초기화
    }
    
    private let outingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.isScrollEnabled = true
        $0.backgroundColor = .background
    }
    
    private let outingIsNilImage = UIImageView().then {
        $0.image = UIImage(named: "outingIsNilImage.svg")
        $0.isHidden = true
    }
    
    private let outingIsNilText = UILabel().then {
        $0.text = "다들 바쁜가봐요..!"
        $0.font = UIFont.GOMSFont(
            size: 16,
            family: .Medium
        )
        $0.textColor = UIColor(
            red: 150/255,
            green: 150/255,
            blue: 150/255,
            alpha: 1
        )
        $0.isHidden = true
    }
    
    override func addView() {
        [outingMainText, outingCollectionView, outingIsNilImage, outingIsNilText].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        outingMainText.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset((bounds.height) / 7.73)
            $0.leading.equalToSuperview().offset(26)
        }
        outingCollectionView.snp.makeConstraints {
            $0.top.equalTo(outingMainText.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview()
        }
        outingIsNilImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        outingIsNilText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(outingIsNilImage.snp.bottom).offset(20)
        }
    }

}

extension OutingViewController:
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OutingCollectionViewCell.identifier, for: indexPath) as? OutingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.applySketchShadow(
            color: UIColor.black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 8,
            spread: 0
        )
        cell.userProfile.image = UIImage(named: "userProfile.svg")
        cell.userName.text = "선민재"
        cell.userNum.text = "3학년 1반 11번"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (
                (UIScreen.main.bounds.width) - 52
            ),
            height: (
                90
            )
        )
    }
}
