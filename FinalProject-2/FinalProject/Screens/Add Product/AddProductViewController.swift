//
//  AddProductViewController.swift
//  FinalProject
//
//

import UIKit
import Firebase
class AddProductViewController: UIViewController {
    
    private let db = Firestore.firestore()
    private let scrollView  = UIScrollView()
    private let contentView = UIView()
    private let categorySegmentedControl = UISegmentedControl (items: ["Clothes","Games","Books"])
    private let subCategorySegmentedControl = UISegmentedControl (items: ["Shoes","Bags","Shirts & Pants"])
    private let imagePicker = UIImagePickerController()
    private let storage = Storage.storage()
    private var userPickedImage = UIImage()
    private var categoryValue = "Clothes"
    private var subCategoryValue = "Shoes"
    
    let imageTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Product Image"
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
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Your Name"
        return lbl
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let advertismentTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Product Name"
        return lbl
    }()
    
    private let advertismentTitleTF: UITextField = {
        let textField = UITextField()
        textField.setupTextField(with:  NSAttributedString(string: "",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.label.withAlphaComponent(0.5)]))
        
        return textField
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Product Description"
        return lbl
    }()
    
    private let descriptionTV: UITextView = {
        let tf = UITextView()
        tf.setupTextView()
        return tf
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setupButton(with: "Add")
        return btn
    }()
    
    private let categoryTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Select a Category"
        return lbl
    }()
    private let subCategoryTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .colorGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Select a Sub Category"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .systemGray6
        }
        title = "Add Product"
        setupScrollView()
        setupView()
        fetchCurrentUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+20)
    }
    
    private func setupScrollView(){
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .AppBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
                            if let userName = data["name"] as? String
                            {
                                DispatchQueue.main.async {
                                    self.nameLabel.text = userName
                                    
                                }
                                
                                
                            }
                        }
                    }
                }
                
            }
    }
    
    private func setupView() {
        
        UISegmentedControl.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .medium)], for: .normal)
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        
        contentView.backgroundColor = UIColor(#colorLiteral(red: 0.9591174722, green: 0.9726384282, blue: 1, alpha: 1))
        scrollView.backgroundColor = UIColor(#colorLiteral(red: 0.9591174722, green: 0.9726384282, blue: 1, alpha: 1))
        view.backgroundColor = UIColor(#colorLiteral(red: 0.9591174722, green: 0.9726384282, blue: 1, alpha: 1))
        categorySegmentedControl.backgroundColor = UIColor(#colorLiteral(red: 0.9402659535, green: 0.9504980445, blue: 0.9720337987, alpha: 1))
        categorySegmentedControl.selectedSegmentTintColor = UIColor(#colorLiteral(red: 1, green: 0.9365367293, blue: 0.7600321174, alpha: 1))
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        categorySegmentedControl.addTarget(self, action: #selector(self.categoryValueChanged(_:)), for: .valueChanged)
        self.categorySegmentedControl.selectedSegmentIndex = 0
        
        subCategorySegmentedControl.backgroundColor = UIColor(#colorLiteral(red: 0.9402659535, green: 0.9504980445, blue: 0.9720337987, alpha: 1))
        subCategorySegmentedControl.selectedSegmentTintColor = UIColor(#colorLiteral(red: 1, green: 0.9365367293, blue: 0.7600321174, alpha: 1))
        subCategorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        subCategorySegmentedControl.addTarget(self, action: #selector(self.subCategoryValueChanged(_:)), for: .valueChanged)
        
        self.subCategorySegmentedControl.selectedSegmentIndex = 0
        
        descriptionTV.delegate = self
        
        scrollView.addSubview(imageTitle)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameTitleLabel)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(advertismentTitleLabel)
        scrollView.addSubview(advertismentTitleTF)
        scrollView.addSubview(descriptionTitleLabel)
        scrollView.addSubview(descriptionTV)
        scrollView.addSubview(categoryTitleLabel)
        scrollView.addSubview(categorySegmentedControl)
        scrollView.addSubview(subCategoryTitleLabel)
        scrollView.addSubview(subCategorySegmentedControl)
        scrollView.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            imageTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            imageView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 138),
            
            nameTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            nameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            advertismentTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            advertismentTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            advertismentTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            
            advertismentTitleTF.topAnchor.constraint(equalTo: advertismentTitleLabel.bottomAnchor, constant: 10),
            advertismentTitleTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            advertismentTitleTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            advertismentTitleTF.heightAnchor.constraint(equalToConstant: 45),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: advertismentTitleTF.bottomAnchor, constant: 30),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            descriptionTV.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionTV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTV.heightAnchor.constraint(equalToConstant: 85),
            
            
            
            categoryTitleLabel.topAnchor.constraint(equalTo: descriptionTV.bottomAnchor, constant: 30),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            categorySegmentedControl.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 10),
            categorySegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categorySegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categorySegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            
            subCategoryTitleLabel.topAnchor.constraint(equalTo: categorySegmentedControl.bottomAnchor, constant: 30),
            subCategoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subCategoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            subCategorySegmentedControl.topAnchor.constraint(equalTo: subCategoryTitleLabel.bottomAnchor, constant: 10),
            subCategorySegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subCategorySegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subCategorySegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            
            
            addButton.topAnchor.constraint(equalTo: subCategorySegmentedControl.bottomAnchor, constant: 30),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    
    
    @objc private func categoryValueChanged(_ sender: UISegmentedControl) {
        categoryValue = categorySegmentedControl.titleForSegment(at: sender.selectedSegmentIndex)!
        switch sender.selectedSegmentIndex {
        case 0:
            subCategorySegmentedControl.setTitle("Shoes", forSegmentAt: 0)
            subCategorySegmentedControl.setTitle("Bags", forSegmentAt: 1)
            subCategorySegmentedControl.setTitle("Shirts & Pants", forSegmentAt: 2)
            print("Clothes")
        case 1:
            subCategorySegmentedControl.setTitle("Kids & Toys", forSegmentAt: 0)
            subCategorySegmentedControl.setTitle("Adults & Video Games", forSegmentAt: 1)
            subCategorySegmentedControl.setTitle("Board & Cards games", forSegmentAt: 2)
            print("Games")
        case 2:
            subCategorySegmentedControl.setTitle("Kids & Education", forSegmentAt: 0)
            subCategorySegmentedControl.setTitle("Fiction", forSegmentAt: 1)
            subCategorySegmentedControl.setTitle("Science", forSegmentAt: 2)
            print("Books")
        default:
            break
        }
    }
    @objc private func subCategoryValueChanged(_ sender: UISegmentedControl) {
        subCategoryValue = subCategorySegmentedControl.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    
    private func setupImagePicker() {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    @objc func imageTapped() {
        setupImagePicker()
    }
    
    
    @objc private func addButtonTapped() {
        guard let user = Auth.auth().currentUser else {return}
        guard let advertismentTF = advertismentTitleTF.text else {return}
        guard let descriptionTextView = descriptionTV.text else {return}
        
        if advertismentTF.isEmpty || descriptionTextView.isEmpty || categoryValue.isEmpty || subCategoryValue.isEmpty{
            let alert = UIAlertController(title: "Something went wrong!", message: "Please make sure you completed all the product's fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            self.showUIActivityIndicator()
            guard let d: Data = userPickedImage.jpegData(compressionQuality: 0.5) else { return }
            guard let currentUser = Auth.auth().currentUser else {return}
            
            let uuid = UUID()
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            let ref = storage.reference().child("advertisement/\(currentUser.email!)/\(currentUser.uid)\(uuid).jpg")
            
            
            ref.putData(d, metadata: metadata) { (metadata, error) in
                if error == nil {
                    ref.downloadURL(completion: { (url, error) in
                        self.saveToFireStore(advertismentTF: advertismentTF, descriptionTextView: descriptionTextView, userId: user.uid, url: url, uuid: uuid)
                    })
                }else{
                    print("error \(String(describing: error))")
                }
            }
            
        }
        
    }
    
    private func saveToFireStore(advertismentTF: String, descriptionTextView: String, userId: String, url: URL?, uuid: UUID) {
        
        let ref = db.collection("advertisement").document()
        ref.setData([
            "name": self.nameLabel.text!,
            "product name": advertismentTF,
            "product description": descriptionTextView,
            "product category": categoryValue,
            "product subCategory": subCategoryValue,
            "userID": userId,
            "userImageURL": "\(url!)",
            "docID": ref.documentID,
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                DispatchQueue.main.async {
                    self.hideUIActivityIndicator()
                    let alert = UIAlertController(title: "Awesome!", message: "Your advertisement have been created", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    self.advertismentTitleTF.text = ""
                    self.descriptionTV.text = ""
                }
            }
            
        }
    }
}

extension AddProductViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        descriptionTitleLabel.text = "Product Description " + "80/" + "\(updatedText.count - 1)"
        return updatedText.count <= 80
    }
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        imageView.image = userPickedImage
        self.userPickedImage = userPickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
