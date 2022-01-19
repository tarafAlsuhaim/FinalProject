//
//  ProductsViewController.swift
//  FinalProject
//
//

import UIKit
import Firebase

class ProductsVC: UIViewController {
    
    private var collectionView: UICollectionView!
    var products = [Product]()
    private let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .AppBackground
        navigationItem.largeTitleDisplayMode = .always
        configureCollectionView()
    }
    
    
    
    //MARK: - Setup collection view
    private func configureCollectionView(){
        collectionView                      = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: generateLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .AppBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = true
        
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.id)
        view.addSubview(collectionView)
    }
    
    //MARK: - Generate layout for collectionView
    
    private func generateLayout() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 20, trailing: 20)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(330)),
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            
            return section
            
        }
    }
}

//MARK: - Data Source and Delegate Methods For Collection View

extension ProductsVC: UICollectionViewDelegate , UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.id, for: indexPath) as! ProductsCell
        
        readImageFromFirestore(with: products[indexPath.row].imageURL) { image in
            
            DispatchQueue.main.async {
                cell.setCell(card: self.products[indexPath.row], image: image)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProductsCell else { return }
        
        let vc = ProductsDetailVC()
        vc.products = products[indexPath.row]
        vc.title = products[indexPath.row].subCategory
        vc.img = cell.cardImageView.image ?? UIImage()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        DispatchQueue.main.async {
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3) {
                cell.transform = CGAffineTransform.identity
            }
        }
        
    }
    private func readImageFromFirestore(with url: String, completion: @escaping (UIImage) -> ()){
        
        
        if  url != "NA"
        {
            print(url)
            let httpsReference = self.storage.reference(forURL: url)
            
            
            httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("ERROR GETTING DATA \(error.localizedDescription)")
                } else {
                    
                    completion(UIImage(data: data!) ?? UIImage())
                    
                }
            }
            
        }
    }
    
}
