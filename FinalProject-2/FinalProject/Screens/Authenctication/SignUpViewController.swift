//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by Taraf Bin suhaim on 29/05/1443 AH.
//
import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()

    private let illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    //MARK: - title
    lazy var titl: UILabel = {
        $0.text = """
        Create
        Account
        """
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        $0.textColor = .iconTab
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    //MARK: - Name
    lazy var name: UILabel = {
        $0.text = "Name"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    lazy var nameText: UITextField = {
        $0.textAlignment = .left
        $0.placeholder = " Enter your name"
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    //MARK: - Email
    lazy var email: UILabel = {
        $0.text = "Email"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    lazy var emailText: UITextField = {
        $0.textAlignment = .left
        $0.placeholder = " Enter your email"
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    //MARK: - Password
    lazy var password: UILabel = {
        $0.text = "Password"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    lazy var passwordText: UITextField = {
        $0.textAlignment = .left
        $0.placeholder = " Enter your password"
        $0.isSecureTextEntry = true
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())

    //MARK: - SignUp
    lazy var signUp: UIButton = {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .iconTab
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 0.25
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    //MARK: - SignIn
    lazy var signIn: UIButton = {
        $0.setTitle("Sign in", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(signin), for: .touchDown)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    lazy var x: UILabel = {
        $0.text = "Already have an account?"
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
        setUpConstraints()
        createAccountTapped()
    }
    //MARK: -
    private func setUpUlElement(){
        view.addSubview(illustrationImage)
        view.addSubview(titl)
        view.addSubview(name)
        view.addSubview(nameText)
        nameText.customTextfield()
        view.addSubview(email)
        view.addSubview(emailText)
        emailText.customTextfield()
        view.addSubview(password)
        view.addSubview(passwordText)
        passwordText.customTextfield()
        view.addSubview(signUp)
        view.addSubview(signIn)
        view.addSubview(x)
    }
    //MARK: - Constraints

    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            illustrationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            illustrationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            illustrationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            illustrationImage.heightAnchor.constraint(equalToConstant: 200),
            illustrationImage.widthAnchor.constraint(equalToConstant: 100),


            titl.topAnchor.constraint(equalTo: illustrationImage.topAnchor,constant: 50),
            titl.bottomAnchor.constraint(equalTo: email.topAnchor, constant: -20),
            titl.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),

            name.topAnchor.constraint(equalTo: titl.topAnchor , constant: 250),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 20),

            nameText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20 ),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameText.heightAnchor.constraint(equalToConstant: 35),

            email.topAnchor.constraint(equalTo: name.bottomAnchor , constant: 80),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),

            emailText.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20 ),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailText.heightAnchor.constraint(equalToConstant: 35),

            password.topAnchor.constraint(equalTo: email.bottomAnchor , constant: 80),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),

            passwordText.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20 ),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordText.heightAnchor.constraint(equalToConstant: 35),

            signUp.topAnchor.constraint(equalTo: passwordText.bottomAnchor , constant: 40),
            signUp.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20),
            signUp.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            signUp.heightAnchor.constraint(equalToConstant: 45),
            
            x.topAnchor.constraint(equalTo: signUp.bottomAnchor ,constant: 20),
            x.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
        
            signIn.topAnchor.constraint(equalTo: signUp.bottomAnchor ,constant: 15),
            signIn.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -110),
        ])
    }

    @objc private func signin() {
        let nextVC = SignInViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    //MARK: - Check User Account
    @objc private func createAccountTapped() {
        guard let name = nameText.text else {return}
        guard let email = emailText.text else {return}
        guard let password = passwordText.text else {return}

        if !email.isEmpty && !password.isEmpty && !name.isEmpty{
            signupUserUsing(email: email, password: password, name: name)
        } else{
            let alert = UIAlertController(title: "Sign Up!", message: "please make sure name, email and password are not empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    //MARK: - Write db
    private func signupUserUsing(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { results, error in

            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:

                    let alert = UIAlertController(title: "Sign Up!", message: "email Already in use", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)

                case .invalidEmail:

                    let alert = UIAlertController(title: "Sign Up!", message: "are sure you typed the email correctly?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)

                case .weakPassword:

                    let alert = UIAlertController(title: "Sign Up!", message: "Your password is weak, please make sure it's strong.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)

                default:

                    let alert = UIAlertController(title: "Sign Up!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)

                }

            }else {
                guard let user = results?.user else {return}

                self.db.collection("Users").document(user.uid).setData([
                    "name": name,
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
//MARK: - Extension TextField
extension UITextField {

    func customTextfield (){
        let underLineView = UIView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        addSubview(underLineView)
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            underLineView.heightAnchor.constraint(equalToConstant: 1 )
        ])
    }

    func setLeftImage(imageName:String) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView;
        self.leftViewMode = .always
    }
}



extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameText.resignFirstResponder()
        passwordText.resignFirstResponder()
        emailText.resignFirstResponder()
        return true
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

