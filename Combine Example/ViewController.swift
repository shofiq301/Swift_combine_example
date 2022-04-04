//
//  ViewController.swift
//  Combine Example
//
//  Created by Md Shofiulla on 4/4/22.
//

import UIKit
import Combine

class MyCustomTableViewCell: UITableViewCell {
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var myDayLableView: UITableView!
    var myDayList = [String]()
    
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    var observers: [AnyCancellable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myDayLableView.register(MyCustomTableViewCell.self, forCellReuseIdentifier: "cell")
        myDayLableView.dataSource = self
        RemoteDataSource.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self]
                completion in
                switch(completion){
                case .finished:
                    self?.myIndicator.stopAnimating()
                case .failure(let error):
                    print(String(describing: error))
                }
                
            }, receiveValue: { [weak self] result in
                self?.myDayList = result
                self?.myDayLableView.reloadData()
            }).store(in: &observers)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observers.removeAll()
    }
    
    
}
extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDayList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = myDayList[indexPath.row]
        return cell
    }
}

