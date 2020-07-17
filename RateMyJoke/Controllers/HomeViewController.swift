//
//  HomeViewController.swift
//  RateMyJoke
//
//  Created by Michelle Lau on 2020/07/13.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

let FIREBASE_COLLECTION_NAME = "Jokes"

class HomeViewController: UITableViewController {
    
    var jokes = [Joke]()
    let db = Firestore.firestore()
    let plus = UIImage(systemName: "plus")

    let nib = UINib(nibName: "JokeCell", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Jokes"
        self.tableView.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutUser))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plus, style: .done, target: self, action: #selector(addJoke))
        fetchJokes()
    }
    
    @objc func addJoke() {
        let alert = UIAlertController(title: "Add your joke below", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let addJoke = UIAlertAction(title: "Add", style: .default) { (action) in
            let jokeString = alert.textFields?[0].text ?? ""
            if jokeString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                self.db.collection(FIREBASE_COLLECTION_NAME).addDocument(data: ["description": jokeString, "likes" : 0, "dislikes": 0]) { (error) in
                    guard error == nil else {
                        self.showAlert(title: "Error", message: error?.localizedDescription ?? "An error occurred")
                        return
                    }
                    print("Check Firebase")
                    self.fetchJokes()
                }
            }
        }
        alert.addAction(addJoke)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your joke here!"
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func logoutUser() {
        if Auth.auth().currentUser != nil {
            try? Auth.auth().signOut()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchJokes() {
        jokes = []
        db.collection(FIREBASE_COLLECTION_NAME).getDocuments { (response, error) in
            guard error == nil else {
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            print("response is \(String(describing: response))")
            if let response = response {
                for document in response.documents {
                    let newJoke = Joke(description: document.data()["description"] as? String ?? "", likes: document.data()["likes"] as? Int ?? 0, dislikes: document.data()["dislikes"] as? Int ?? 0)
                    self.jokes.append(newJoke)

//                    print(document.data()["description"])
//                    let newJoke = Joke(json: document.data())
                }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(nib, forCellReuseIdentifier: "JokeCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as? JokeCell
        if let cell = cell {
            let joke = self.jokes[indexPath.row]
            cell.joke = joke
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
