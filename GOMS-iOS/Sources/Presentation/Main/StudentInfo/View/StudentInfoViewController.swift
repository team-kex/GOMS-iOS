import UIKit
import SnapKit
import Then

class StudentInfoViewController: BaseViewController<StudentInfoViewModel> {

    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "학생 정보 수정"
        super.viewDidLoad()
        studentIntoCollectionView.dataSource = self
        studentIntoCollectionView.delegate = self
        studentIntoCollectionView.register(
            StudentInfoCell.self,
            forCellWithReuseIdentifier: StudentInfoCell.identifier
        )
        studentIntoCollectionView.collectionViewLayout = layout
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private var searchBarButton = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.applySketchShadow(
            color: UIColor.black,
            alpha: 0.1,
            x: 0,
            y: 2,
            blur: 8,
            spread: 0
        )
        $0.layer.cornerRadius = 10
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
    
    private let studentIntoCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.isScrollEnabled = true
        $0.backgroundColor = .background
    }
    
    private let searchBarText = UILabel().then {
        $0.text = "찾으시는 학생이 있으신가요?"
        $0.textColor = UIColor.subColor
        $0.font = UIFont.GOMSFont(size: 14, family: .Regular)
    }
    
    private let searchIcon = UIImageView().then {
        $0.image = UIImage(named: "searchIcon")
    }
    
    override func addView() {
        [searchBarButton, studentIntoCollectionView, searchBarText, searchIcon].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        searchBarButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(121)
            $0.height.equalTo(52)
            $0.trailing.leading.equalToSuperview().inset(26)
        }
        studentIntoCollectionView.snp.makeConstraints{
            $0.top.equalTo(searchBarButton.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview()
        }
        searchBarText.snp.makeConstraints {
            $0.centerY.equalTo(searchBarButton.snp.centerY).offset(0)
            $0.leading.equalTo(searchBarButton.snp.leading).offset(20)
        }
        searchIcon.snp.makeConstraints {
            $0.centerY.equalTo(searchBarButton.snp.centerY).offset(0)
            $0.trailing.equalTo(searchBarButton.snp.trailing).inset(20)
        }
    }

}
extension StudentInfoViewController:
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudentInfoCell.identifier, for: indexPath) as? StudentInfoCell else {
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
        cell.userNum.text = "3111"
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