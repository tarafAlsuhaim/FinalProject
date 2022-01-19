//
//  UpdateProfileVC.swift
//  FinalProject
//
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class UpdateProfileVC: UIViewController {
    private let imagePicker = UIImagePickerController()
    private var userPickedImage : UIImage?
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private var email = ""
    
    let imageTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "User Image"
        return lbl
    }()
    
    let imageView: UIImageView = {
        let pI = UIImageView()
        pI.contentMode = .scaleAspectFit
        pI.clipsToBounds = true
        pI.layer.cornerRadius = 13
        pI.layer.borderColor = UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1)).cgColor
        pI.layer.borderWidth = 1
        pI.image = UIImage(systemName: "photo")?.withTintColor(UIColor(#colorLiteral(red: 0.9864818454, green: 0.8801614642, blue: 0.5650160313, alpha: 1))).withRenderingMode(.alwaysOriginal)
        pI.translatesAutoresizingMaskIntoConstraints = false
        return pI
    }()
    
    private let nameTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Name"
        return lbl
    }()
    
    private let nameTitleTF: UITextField = {
        let textField = UITextField()
        textField.setupTextField(with:  NSAttributedString(string: "",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.5)]))
        
        return textField
    }()
    
    private let emailTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Email"
        return lbl
    }()
    
    private let emailTitleTF: UITextField = {
        let textField = UITextField()
        textField.setupTextField(with:  NSAttributedString(string: "",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.5)]))
        
        return textField
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(with: "Save changes")
        return btn
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .AppBackground
        fetchCurrentUsers()
        setupViews()
    }
    
    func setupViews(){
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(imageTitle)
        view.addSubview(imageView)
        view.addSubview(nameTitleLabel)
        view.addSubview(nameTitleTF)
        view.addSubview(emailTitleLabel)
        view.addSubview(emailTitleTF)
        view.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            imageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            imageView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 138),
            
            nameTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            nameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            
            nameTitleTF.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 10),
            nameTitleTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTitleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTitleTF.heightAnchor.constraint(equalToConstant: 45),
            
            emailTitleLabel.topAnchor.constraint(equalTo: nameTitleTF.bottomAnchor, constant: 30),
            emailTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            
            emailTitleTF.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 10),
            emailTitleTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTitleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTitleTF.heightAnchor.constraint(equalToConstant: 45),
            
            addButton.topAnchor.constraint(equalTo: emailTitleTF.bottomAnchor, constant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc private func addButtonTapped() {
        guard let user = Auth.auth().currentUser else {return}
        guard let nameTF = nameTitleTF.text else {return}
        guard let emailTF = emailTitleTF.text else {return}
        if nameTF.isEmpty || emailTF.isEmpty {
            let alert = UIAlertController(title: "Something went wrong!", message: "Please make sure you completed all the product's fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            if self.email != emailTF {
                changeEmail(nameTF: nameTF, emailTF: emailTF, userId: user.uid)
            } else{
                saveToFireStore(nameTF: nameTF, emailTF: emailTF, userId: user.uid)
            }
            
            
        }
    }
    
    func changeEmail(nameTF: String, emailTF: String, userId: String) {
        var password = UserDefaults.standard.string(forKey: "password")
        if let pass = password{
            Auth.auth().signIn(withEmail: self.email, password: password!) {results, error in
                if let err = error{
                    self.PasswordAlert(nameTF: nameTF, emailTF: emailTF, userId: userId)
                } else {
                Auth.auth().currentUser?.updateEmail(to: self.emailTitleTF.text!) { (error) in
                    if let err = error{
                        let alert = UIAlertController(title: "Error!", message: "Something went wrong", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    } else {
                        self.saveToFireStore(nameTF: nameTF, emailTF: emailTF, userId: userId)
                    }
                }
                }
            }
        } else {
            PasswordAlert(nameTF: nameTF, emailTF: emailTF, userId: userId)
        }
        
    }
    func PasswordAlert(nameTF: String, emailTF: String, userId: String){
        let alertController = UIAlertController(title: "To Change Email", message: "", preferredStyle: UIAlertController.Style.alert)
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let password = alertController.textFields![0] as UITextField
            UserDefaults.standard.setValue(password.text!, forKey: "password")
            self.changeEmail(nameTF: nameTF, emailTF: emailTF, userId: userId)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                                            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Password"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func saveToFireStore(nameTF: String, emailTF: String, userId: String) {
        
        guard let currentUser = Auth.auth().currentUser else {return}
        
        let uuid = UUID()
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("Users/\(currentUser.email!)/\(currentUser.uid)\(uuid).jpg")
        if let d: Data = userPickedImage?.jpegData(compressionQuality: 0.5)
        {
            self.showUIActivityIndicator()
            ref.putData(d, metadata: metadata) { (metadata, error) in
                if error == nil {
                    ref.downloadURL(completion: { (url, error) in
                                        
                                        let ref = self.db.collection("Users").document(userId)
                                        
                                        ref.updateData([
                                            "name": nameTF,
                                            "email": emailTF,
                                            "userID": userId,
                                            "userImageURL": "\(url!)"
                                        ]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                print("Document successfully updated!")
                                                DispatchQueue.main.async {
                                                    self.hideUIActivityIndicator()
                                                    let alert = UIAlertController(title: "Awesome!", message: "Record updated", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                                    self.present(alert, animated: true)
                                                }
                                            }
                                            
                                        }                })
                }else{
                    print("error \(String(describing: error))")
                }
            }
        }else {
            let ref = self.db.collection("Users").document(userId)
            
            ref.updateData([
                "name": nameTF,
                "email": emailTF,
                "userID": userId
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully updated!")
                    DispatchQueue.main.async {
                        self.hideUIActivityIndicator()
                        let alert = UIAlertController(title: "Awesome!", message: "Record updated", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                
            }
        }
        
    }
    
    @objc func imageTapped() {
        setupImagePicker()
    }
    
    private func setupImagePicker() {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
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
                                    self.nameTitleTF.text = userName
                                    self.emailTitleTF.text = email
                                    self.email = email
                                    
                                }
                                
                            }
                            if let url = data["userImageURL"] as? String{
                                self.readImageFromFirestore(with: url) { image in
                                    
                                    DispatchQueue.main.async {
                                        self.imageView.image = image
                                        self.userPickedImage = image
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


extension UpdateProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        imageView.image = userPickedImage
        self.userPickedImage = userPickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
