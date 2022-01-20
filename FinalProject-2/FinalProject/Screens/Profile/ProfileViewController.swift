//
//  ProfileViewController.swift
//  FinalProject
//
//

import UIKit
import Firebase

class ProfileViewController: UIViewController{
    
    private var collectionView: UICollectionView!
    private var products = [Product]()
    private let storage = Storage.storage()
    private let db = Firestore.firestore()
    private let containerView = UIView()
    
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "person-icon")
        return image
    }()
    
    
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private lazy var editButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .medium
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1))
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        configuration.attributedTitle = AttributedString("Edit", attributes: container)
        let butt = UIButton(configuration: configuration, primaryAction: nil)
        butt.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return butt
    }()
    
    

    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .AppBackground
        
        title = "Profile"
        
        
        configureCollectionView()
        setupViews()
        
        fetchCurrentUsers()
        fetchCurrentUsers()
        
   
        let signOutButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(signOutTapped))
        signOutButton.tintColor = .red
        self.navigationItem.rightBarButtonItem  = signOutButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getProductsDataForUser()
        fetchCurrentUsers()
    }
    
    //MARK: - Setup collection view
    private func configureCollectionView(){
        collectionView                      = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.autoresizingMask     = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor      = UIColor(#colorLiteral(red: 0.9591174722, green: 0.9726384282, blue: 1, alpha: 1))
        collectionView.delegate             = self
        collectionView.dataSource           = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.id)
        collectionView.register(ProfileSectionHeader.self, forSupplementaryViewOfKind: "SectionHeaderElementKind" , withReuseIdentifier: ProfileSectionHeader.reuseIdentifier)
        collectionView.backgroundColor = .AppBackground
        view.addSubview(collectionView)
        
    }
    //MARK: - Generate layout for collectionView
    
    private func generateLayout() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(330)),
                                                           subitems: [item])
            
            let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "SectionHeaderElementKind", alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [headerItem]
            
            return section
            
        }
    }
    //MARK: - Gets current user so we can used it to populate the views
    private func fetchCurrentUsers() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.collection("Users").whereField("email", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["name"] as? String, let email = data["email"] as? String
                            {
                                
                                
                                DispatchQueue.main.async {
                                    self.nameLabel.text = userName
                                    self.emailLabel.text = email
                                }
                                
                                
                            }
                            if let url = data["userImageURL"] as? String{
                                self.readImageFromFirestore(with: url) { image in
                                    
                                    DispatchQueue.main.async {
                                        self.avatar.image = image
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
    }
    //MARK: - Views Configuration
    private func setupViews(){
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.addSubview(vStack)
   
        
        vStack.addArrangedSubview(avatar)
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(emailLabel)
        vStack.addArrangedSubview(editButton)
        
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            avatar.widthAnchor.constraint(equalToConstant: 80),
            avatar.heightAnchor.constraint(equalToConstant: 80),
            editButton.widthAnchor.constraint(equalToConstant: 200),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            vStack.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            vStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
             
            collectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor,constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    
    
    @objc func signOutTapped() {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure to sign out?", preferredStyle: .alert)
        let signOut = UIAlertAction(title: "Sign Out", style: .destructive) { alertAction in
            self.signOut()
        }
        alert.addAction(signOut)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func signOut() {
        do {
            try Auth.auth().signOut()
            self.tabBarController?.selectedIndex = 0
        }catch {
            print("Error: ",error.localizedDescription)
        }
    }
}


//MARK: - Data Source and Delegate Methods For Collection View

extension ProfileViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.id, for: indexPath) as! ProfileCell
        
        cell.contentView.isUserInteractionEnabled = false
        
        readImageFromFirestore(with: products[indexPath.row].imageURL) { image in
            
            DispatchQueue.main.async {
                cell.setCell(card: self.products[indexPath.row], image: image)
            }
        }
        
        cell.buttonDeleteActionHandler = { cell in
            let product = self.products.remove(at: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
            self.deleteData(for: product.docID)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "SectionHeaderElementKind",withReuseIdentifier: ProfileSectionHeader.reuseIdentifier, for: indexPath) as! ProfileSectionHeader

        return headerView
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
    private func getProductsDataForUser() {
        guard let user = Auth.auth().currentUser else {return}
        db.collection("advertisement").whereField("userID", isEqualTo: user.uid)
            .addSnapshotListener { snapshShot, error in
                self.products = []
                if error != nil {
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "ERROR", message: "something went wrong, we apologies", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                }else {
                    if snapshShot!.documents.isEmpty {
                        
                    }else{
                        for doc in snapshShot!.documents {
                            let data = doc.data()
                            self.products.append(Product(imageURL: data["userImageURL"] as? String ?? "NA", title: data["product name"] as? String ?? "No Title", description: data["product description"] as? String ?? "This product has no description", subCategory: data["product subCategory"] as? String ?? "There is no string", nameOfSeller: data["name"] as? String ?? "There is no name", docID: data["docID"] as? String ?? "NA", userID: data["userID"] as? String ?? ""))
                        }
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    }
                }
                
                
            }
    }
    
    private func deleteData(for document: String) {
        db.collection("advertisement").document(document).delete { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                
            }
            
            
        }
    }
    
    @objc func didTapEditButton() {
        let vc = UpdateProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
        print("didTapEditButton")
    }
    
}
