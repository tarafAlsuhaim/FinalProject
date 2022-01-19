//
//  AddCommentVC.swift
//  FinalProject
//
//

import UIKit
import Firebase


class AddCommentVC: UIViewController {
    
    let db = Firestore.firestore()
    var products: Product!
   
    
    let commentTitleLabel: UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Your Comment: characters Limit "
        return lbl
    }()
    
    let commentTV: UITextView = {
        let tf = UITextView()
        tf.setupTextView()
        return tf
    }()
    
    
    let sendCommentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(with: "SEND")
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupPresenetationMode()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(commentTitleLabel)
        view.addSubview(commentTV)
        view.addSubview(sendCommentButton)
        commentTV.delegate = self
   
        sendCommentButton.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            commentTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            commentTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            commentTV.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor, constant: 0),
            commentTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentTV.heightAnchor.constraint(equalToConstant: 80),
            
            sendCommentButton.topAnchor.constraint(equalTo: commentTV.bottomAnchor, constant: 5),
            sendCommentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendCommentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendCommentButton.heightAnchor.constraint(equalToConstant: 45),
            
            
            
        ])
    }
    private func setupPresenetationMode() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
    }
    

    @objc private func sendComment() {
        if commentTV.text.isEmpty {
            let alert = UIAlertController(title: "ERROR", message: "you can't add an empty comment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }else {
            fetchCurrentUsers { nameOfUser in
                self.db.collection("advertisement").document(self.products.docID).collection("comments").document().setData([
                
                    "comment": self.commentTV.text!,
                    "by": nameOfUser,
                
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }

                }
            }
            
        }
    }
    private func fetchCurrentUsers(completion: @escaping (String) -> Void) {
        var name = ""
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}
        db.collection("Users").whereField("email", isEqualTo: String(currentUserName.email!))
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["name"] as? String
                            {
                                
                                    name = userName
                            }
                        }
                        completion(name)
                    }
                }
                
            }
    }
   
    
}




extension AddCommentVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        commentTitleLabel.text = "Your Comment: characters Limit " + "80/" + "\(updatedText.count - 1)"
        return updatedText.count <= 80
    }
}
