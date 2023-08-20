//
//  MainPageViewController.swift
//  nagaGrinGirinGrim
//
//  Created by 보경 on 2023/08/14.
//

import UIKit

class MainPageViewController: UIViewController {
    
    let userData = UserData.shared
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func resetUserDefaultsValue(_ sender: Any) {
        userData.resetDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        // naviagation bar hidden
        self.navigationController?.isNavigationBarHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
/*--------------------------컬렉션뷰 레이아웃---------------------------*/
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        flowlayout.estimatedItemSize = .zero
            
        }
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
/*-------------------------------------------------------------------*/
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        
        print("view will appear")
        print(defaults.array(forKey: "postTitles")?.count ?? userData.postTitles.count)
    }
}

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaults.array(forKey: "postTitles")?.count ?? userData.postTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaults.set(indexPath.item, forKey: "selectedIndexPath")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCustom", for: indexPath) as?
                CellCustom else {
            return UICollectionViewCell()
        }
        func connectData() {
        }
        let postTitles = (defaults.array(forKey: "postTitles") ?? userData.postTitles)
        let postImgNames = (defaults.array(forKey: "postImgNames") ?? userData.postImgNames)
                
        cell.postTitles.text = postTitles[indexPath.item] as? String
        cell.postImgNames.image = UIImage(named: postImgNames[indexPath.item] as! String)
        print(postImgNames[indexPath.item])
        
        // cell 꾸미기
        cell.layer.cornerRadius = 30
        cell.backgroundColor = .white
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowRadius = 20
        
        // postCard 꾸미기
        cell.postCard.layer.cornerRadius = 30
        cell.postCard.backgroundColor = UIColor(cgColor: CGColor(red: 255, green: 255, blue: 255, alpha: 0.5))
        cell.postCard.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.postCard.layer.shadowOpacity = 0.3
        cell.postCard.layer.shadowRadius = 10

        return cell
    }
}


/*------------------- 컬렉션뷰 레이아웃 ----------------*/
extension MainPageViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let interItemSpacing: CGFloat = 10
    let width = (collectionView.bounds.width - interItemSpacing * 3) / 2
    let height = width
    return CGSize(width: width, height: height)
    }
}
