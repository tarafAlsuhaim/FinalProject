//
//  HomeViewController.swift
//  FinalProject
//
//


import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    var productsArrayToPass = [Product]()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .AppBackground
        configureCollectionView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isUserIsSignedIn() {
            showSignupVC()
        }
        
    }
    

    //MARK: - Check if user is already signed in
    private func isUserIsSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    //MARK: - Show the sign in screen if user is not signed in
    private func showSignupVC() {
        let vc = UINavigationController(rootViewController: SignInViewController())
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    //MARK: - Profile Button Action Handler
    @objc private func profileButtonTapped() {
        print("send me to profile")
    }
    //MARK: - Setup collection view
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: generateLayout())
        collectionView.autoresizingMask     = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .AppBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(HomeCellHeaderView.self,forSupplementaryViewOfKind: "clothes" ,withReuseIdentifier: "123")
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.id)
        view.addSubview(collectionView)
    }
    
    //MARK: - Generate layout for collectionView
    
    private func generateLayout() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0{
                
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 32, bottom: 0, trailing: 10)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.77),
                    heightDimension: .estimated(175)),
                                                               subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45)), elementKind: "clothes", alignment: .topLeading)]
                return section
            }else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 32, bottom: 0, trailing: 10)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.77),
                    heightDimension: .estimated(330)),
                                                               subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45)), elementKind: "clothes", alignment: .topLeading)]
                return section
            }else{
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 32, bottom: 30, trailing: 12)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.77),
                    heightDimension: .estimated(240)),
                                                               subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45)), elementKind: "clothes", alignment: .topLeading)]
                
                return section
            }
        }
    }
}

//MARK: - Data Source and Delegate Methods For Collection View

extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return HomeDB.dataForClothes.count
        }else if section == 1 {
            return HomeDB.dataForGames.count
        }else{
            return HomeDB.dataForBooks.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerForCollection = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "123", for: indexPath) as! HomeCellHeaderView;
        
        if indexPath.section == 0 {
            headerForCollection.headerLabel.text = HomeDB.dataForClothes[indexPath.row].category.uppercased()
        }else if indexPath.section == 1 {
            headerForCollection.headerLabel.text = HomeDB.dataForGames[indexPath.row].category.uppercased()
        }else {
            headerForCollection.headerLabel.text = HomeDB.dataForBooks[indexPath.row].category.uppercased()
        }
        
        
        return headerForCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.id, for: indexPath) as! HomeCell
            cell.setCell(card: HomeDB.dataForClothes[indexPath.row])
            
            return cell
        }else if indexPath.section == 1 {
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.id, for: indexPath) as! HomeCell
            
            cell.setCell(card: HomeDB.dataForGames[indexPath.row])
            
            return cell
        }else{
            let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.id, for: indexPath) as! HomeCell
            cell.setCell(card: HomeDB.dataForBooks[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        if indexPath.section == 0 {
            getProductsDataForSelectedCell(for: HomeDB.dataForClothes[indexPath.row].subCategory) { [weak self] productsArray in
                
                let vc = ProductsVC()
                vc.products = productsArray
                vc.title = HomeDB.dataForClothes[indexPath.row].subCategory
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.section == 1 {
                
            
                getProductsDataForSelectedCell(for: HomeDB.dataForGames[indexPath.row].subCategory) { [weak self] productsArray in
                    
                    let vc = ProductsVC()
                    vc.products = productsArray
                    vc.title = HomeDB.dataForGames[indexPath.row].subCategory
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            
        }else if indexPath.section == 2{
                getProductsDataForSelectedCell(for: HomeDB.dataForBooks[indexPath.row].subCategory) { [weak self] productsArray in
                    
                    let vc = ProductsVC()
                    vc.products = productsArray
                    vc.title = HomeDB.dataForBooks[indexPath.row].subCategory
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
               
            }
            
     
       
        
        
        }
   
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        DispatchQueue.main.async {
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3) {
                cell.transform = CGAffineTransform.identity
            }
        }
        
    }
    
    func getProductsDataForSelectedCell(for subCategory: String, completion: @escaping ([Product]) -> Void) {
        print(subCategory)
        db.collection("advertisement").whereField("product subCategory", isEqualTo: subCategory)
            .getDocuments() { snapshShot, error in
                self.productsArrayToPass = []
                if error != nil {
                  
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "ERROR", message: "something went wrong, we apologies", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                }else {
                    if snapshShot!.documents.isEmpty {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Oops!", message: " Sorry .. there are no advertisements available for the selected category", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }else{
                        for doc in snapshShot!.documents {
                            let data = doc.data()
                            self.productsArrayToPass.append(Product(imageURL: data["userImageURL"] as? String ?? "NA", title: data["product name"] as? String ?? "No Title", description: data["product description"] as? String ?? "This product has no description", subCategory: data["product subCategory"] as? String ?? "There is no string", nameOfSeller: data["name"] as? String ?? "There is no name", docID: data["docID"] as? String ?? "NA", userID: data["userID"] as? String ?? ""))
                        }
                        completion(self.productsArrayToPass)
                    }
                }
                
                
            }
    }
    
}


