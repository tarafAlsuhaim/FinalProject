import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage
import Firebase


class ChatsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private var myTableView: UITableView!
    
    private let sections: NSArray = ["Chats"]
    private var chats = [Chat]()
    var messages: [Message] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadChat()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chats"
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight+navigationBarHeight, width: displayWidth, height: displayHeight - (0)))
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 44
        
        self.view.addSubview(myTableView)
    }
    func fetchChats(){
        loadChat()
    }
    func loadChat() {
        let db = Firestore.firestore().collection("Chats")
            .whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        db.getDocuments { (chatQuerySnap, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                
                guard let queryCount = chatQuerySnap?.documents.count else {
                    return
                }
                
                if queryCount == 0 {
                    //If documents count is zero that means there is no chat available and we need to create a new instance
                    //                    self.createNewChat()
                }
                else if queryCount >= 1 {
                    self.chats.removeAll()
                    for doc in chatQuerySnap!.documents {
                        
                        let chat = Chat(dictionary: doc.data())
                        var data = chat
                        data?.users.removeAll()
                        for user in chat!.users
                        {
                            if user != Auth.auth().currentUser?.uid
                            {
                                data?.users.append(user)
                            }
                        }
                        self.chats.append(data!)
                        doc.reference.collection("thread")
                            .order(by: "created", descending: false)
                            .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                                if let error = error {
                                    print("Error: \(error)")
                                    return
                                } else {
                                    for message in threadQuery!.documents {
                                        let msg = Message(dictionary: message.data())
                                        self.messages.append(msg!)
                                        print("Data: \(msg?.content ?? "No message found")")
                                    }
                                }
                                self.myTableView.reloadData()
                            })                   }
                } else {
                    print("Let's hope this error never prints!")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        if indexPath.section == 0 {
            print("Value: \(chats[indexPath.row].users[0])")
            let uId = chats[indexPath.row].users[0]
            if uId != Auth.auth().currentUser?.uid
            {
                for msg in messages
                {
                    if uId == msg.senderID
                    {
                        let vc = ChatViewController()
                        vc.user2UID = msg.senderID
                        vc.user2Name = msg.senderName
                        //                            vc.user2ImgUrl = .imageURL
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                    }
                    else if uId == msg.recvicerID
                    {
                        let vc = ChatViewController()
                        vc.user2UID = msg.recvicerID
                        vc.user2Name = msg.recvicerName
                        //                            vc.user2ImgUrl = products.imageURL
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                    }
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return chats.count ?? 0
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        if indexPath.section == 0 {
            let uId = chats[indexPath.row].users[0]
            if uId != Auth.auth().currentUser?.uid
            {
                cell.loadChatImage(Id: uId)
                for msg in messages
                {
                    if uId == msg.senderID
                    {
                        cell.labUerName.text = "\(msg.senderName)"
                        cell.labMessage.text = "\(msg.content)"
                        cell.labTime.text = DateFormatter.localizedString(from: msg.created.dateValue(), dateStyle: .short, timeStyle: .short)
                    }
                    else if uId == msg.recvicerID
                    {
                        cell.labUerName.text = "\(msg.recvicerName)"
                        cell.labMessage.text = "\(msg.content)"
                        cell.labTime.text = DateFormatter.localizedString(from: msg.created.dateValue(), dateStyle: .short, timeStyle: .short)
                    }
                }
            }
        }
        return cell
    }
    
}
