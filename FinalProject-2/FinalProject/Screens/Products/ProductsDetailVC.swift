//
//  ProductsDetailVC.swift
//  FinalProject
//
//

import UIKit
import Firebase

class ProductsDetailVC: UIViewController {
    
    let db = Firestore.firestore()
    var products: Product!
    var img = UIImage()
    var comments = [Comment]()
    
    private var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .insetGrouped)
        tb.rowHeight = 55
        tb.register(ProductsDetailCell.self, forCellReuseIdentifier: ProductsDetailCell.id)
        tb.backgroundColor = .AppBackground
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.backgroundColor = .clear
        lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.numberOfLines = 0
        lbl.backgroundColor = .clear
        lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .regular))
        lbl.textColor = .label
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.backgroundColor = .clear
        lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 11, weight: .bold))
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
//    let com : UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Comments"
//        lbl.backgroundColor = .clear
//        lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .bold))
//        lbl.textColor = .label
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
    let commentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(with: "Commet")
        btn.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    let chatButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(with: "Start the conversation")
        btn.addTarget(self, action: #selector(onClickChatButton), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .AppBackground
        setupViews()
        populateViews()
        getComments()
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
//        view.addSubview(com)
        view.addSubview(commentButton)
        view.addSubview(chatButton)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 245),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    
            chatButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            chatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chatButton.heightAnchor.constraint(equalToConstant: 35),
            chatButton.widthAnchor.constraint(equalToConstant: 215),
            
            commentButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            commentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentButton.heightAnchor.constraint(equalToConstant: 35),
            commentButton.widthAnchor.constraint(equalToConstant: 115),
            
//            com.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
//            com.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            com.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
            tableView.topAnchor.constraint(equalTo: commentButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func populateViews() {
        imageView.image = img
        nameLabel.text = products.nameOfSeller
        titleLabel.text = products.title
        descriptionLabel.text = products.description
    }
    
    
    @objc private func commentButtonTapped() {
        let sheetViewController = AddCommentVC()
        sheetViewController.products = products
        self.present(sheetViewController, animated: true, completion: nil)
    }
    
    @objc func onClickChatButton()
    {
        let vc = ChatViewController()
        vc.user2UID = products.userID
        vc.user2Name = products.nameOfSeller
        vc.user2ImgUrl = products.imageURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ProductsDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsDetailCell.id, for: indexPath) as! ProductsDetailCell
        
        
        cell.nameOfUser.text = comments[indexPath.row].by
        cell.comment.text = comments[indexPath.row].comment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getComments() {
        
        db.collection("advertisement").document(products.docID).collection("comments")
            .addSnapshotListener { snapShot, error in
                
                self.comments = []
                if error != nil {
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "ERROR", message: "something went wrong, we apologies", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                }else {
                    if snapShot!.documents.isEmpty {
                        
                        self.comments.append(Comment(by: "", comment: "There is no comment, be the first one!."))
                    }else{
                        print("Hello")
                        for doc in snapShot!.documents {
                            let data = doc.data()
                            self.comments.append(Comment(by: data["by"] as? String ?? "NA", comment: data["comment"] as? String ?? "NA"))
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
                
            }
        
    }
}
