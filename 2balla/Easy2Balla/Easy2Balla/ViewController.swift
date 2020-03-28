//
//  ViewController.swift
//  Easy2Balla
//
//  Created by apple on 3/28/20.
//  Copyright © 2020 apple. All rights reserved.
//



import UIKit
//import SVProgressHUD

class ViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        uiNotOnMain()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        SVProgressHUD.show()
//        DispatchQueue.global(qos: .background).async {
//            self.bigTask()
//            DispatchQueue.main.async {
//                SVProgressHUD.dismiss()
//            }
//        }
//        print("QWERTY")
        
        downloadFilms()
    }
    
    // MARK: - Methods
    func uiNotOnMain() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.sync {
                self.view.backgroundColor = .red
            }
        }
    }
    
    func bigTask() {
        for i in 0...100000 {
            print(i)
        }
    }
    
    func downloadFilms() {
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=eb193138&s=kung%2Cfu&r=json") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DownloadFilmsResponse.self, from: data)
                
                print(response.totalResults)
                print(response.movies.map { $0.title })
                
                DispatchQueue.main.async {
                    
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // MARK: - Actions
    @IBAction func changeColor(_ sender: UIButton) {
        sender.backgroundColor = .blue
    }
}

class DownloadFilmsResponse: Codable {
    var movies: [Photos]
    var totalResults: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
    }
}
