//
//  CustomTableViewCell.swift
//  FinalProject
//
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class CustomTableViewCell: UITableViewCell {
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    let imgUser = UIImageView()
    let labUerName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgUser.backgroundColor = UIColor.gray
        imgUser.layer.cornerRadius = 23
        imgUser.clipsToBounds = true
        
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labTime.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imgUser)
        contentView.addSubview(labUerName)
        contentView.addSubview(labMessage)
        contentView.addSubview(labTime)
        
        let viewsDict = [
            "image" : imgUser,
            "username" : labUerName,
            "message" : labMessage,
            "labTime" : labTime,
        ] as [String : Any]
        
        NSLayoutConstraint.activate([
            imgUser.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            imgUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imgUser.trailingAnchor.constraint(equalTo: labUerName.leadingAnchor, constant: -8),
            imgUser.trailingAnchor.constraint(equalTo: labMessage.leadingAnchor, constant: -8),
            
            imgUser.heightAnchor.constraint(equalToConstant: 46),
            imgUser.widthAnchor.constraint(equalToConstant: 46),
            
            labUerName.topAnchor.constraint(equalTo: imgUser.topAnchor, constant:0 ),
            labMessage.topAnchor.constraint(equalTo: labUerName.bottomAnchor, constant: 0),
            
            labTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            labTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadChatImage(Id:String){
        db.collection("Users").whereField("userID", isEqualTo: Id)
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let url = data["userImageURL"] as? String{
                                self.readImageFromFirestore(with: url) { image in
                                    
                                    DispatchQueue.main.async {
                                        self.imgUser.image = image
                                    }
                                }
                            }
                        }
                    }
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
