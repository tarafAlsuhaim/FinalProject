//  SignInViewController.swift
//  FinalProject
//
//  Created by Taraf Bin suhaim on 29/05/1443 AH.
//
import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    let db = Firestore.firestore()
    
 //MARK: - image
    private let illustrationImage: UIImageView = {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    //MARK: - title
    lazy var titl: UILabel = {
        $0.text = """
        Welcome
        Back
        """
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        $0.textColor = .iconTab
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    //MARK: - Email
    lazy var email: UILabel = {
        $0.text = "Email"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var emailText: UITextField = {
        $0.textAlignment = .left
        $0.placeholder = "Enter your Email"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    //MARK: - Password
    lazy var password: UILabel = {
        $0.text = "Password"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var passwordText: UITextField = {
        $0.textAlignment = .left
        $0.placeholder = " Enter your password"
        $0.clipsToBounds = true
        $0.isSecureTextEntry = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    //MARK: - SignIn
    lazy var signIn: UIButton = {
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .iconTab
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 0.25
        $0.addTarget(self, action: #selector(signInTapped), for: .touchDown)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    //MARK: - SignIn
    lazy var signup: UIButton = {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.colorGray, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(signOutTapped), for: .touchDown)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    lazy var x: UILabel = {
        $0.text = "Don't have an account?"
        $0.textColor = .lightGray
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .AppBackground
        setUpUlElement()
        setupConstraints()
    }
    //MARK: -
    private func setUpUlElement(){
        view.addSubview(illustrationImage)
        view.addSubview(titl)
        view.addSubview(email)
        view.addSubview(emailText)
        emailText.customTextfield()
        view.addSubview(password)
        view.addSubview(passwordText)
        passwordText.customTextfield()
        view.addSubview(signIn)
        view.addSubview(signup)
        view.addSubview(x)
    }
    //MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            illustrationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            illustrationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            illustrationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            illustrationImage.heightAnchor.constraint(equalToConstant: 200),
            illustrationImage.widthAnchor.constraint(equalToConstant: 100),
        
            titl.topAnchor.constraint(equalTo: illustrationImage.topAnchor,constant: 200),
            titl.bottomAnchor.constraint(equalTo: email.topAnchor, constant: -20),
            titl.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            
            email.topAnchor.constraint(equalTo: titl.topAnchor,constant: 150),
            email.bottomAnchor.constraint(equalTo: emailText.topAnchor, constant: -20),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            
            emailText.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 5),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailText.heightAnchor.constraint(equalToConstant: 35),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor , constant: 80),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            
            passwordText.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20 ),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordText.heightAnchor.constraint(equalToConstant: 35),
            
            signIn.topAnchor.constraint(equalTo: passwordText.bottomAnchor , constant: 60),
            signIn.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20),
            signIn.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            signIn.heightAnchor.constraint(equalToConstant: 45),
            
            x.topAnchor.constraint(equalTo: signIn.bottomAnchor ,constant: 20),
            x.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
        
            signup.topAnchor.constraint(equalTo: signIn.bottomAnchor ,constant: 15),
            signup.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -125),

        ])
    }
    
    @objc private func signOutTapped() {
        let nextVC = SignUpViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: - Write db
    @objc private func signInTapped() {
        guard let email = emailText.text else {return}
        guard let password = passwordText.text else {return}
        
        if !email.isEmpty && !password.isEmpty {
            loginUsing(email: email, password: password)
        }else{
            let alert = UIAlertController(title: "Log in!", message: "please make sure email and password are not empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
    private func loginUsing(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    
                    let alert = UIAlertController(title: "Log in!", message: "you entered a wrong password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                case .invalidEmail:
                    
                    let alert = UIAlertController(title: "Log in!", message: "are sure you typed the email correctly?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                default:
                    
                    let alert = UIAlertController(title: "Log in!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }else{
                guard let user = results?.user else {return}
                
                self.db.collection("Users").document(user.uid).setData([
                    "email": String(user.email!),
                    "userID": user.uid,
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        let nextVC = TabBarController()
                        nextVC.modalPresentationStyle = .fullScreen
                        self.present(nextVC, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

