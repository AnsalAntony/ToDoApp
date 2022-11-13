//
//  HomeViewController.swift
//  itAgenturenToDoApp
//
//  Created by Ansal Antony on 10/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var toDoListTableView: UITableView!

    private let homeViewModel =  HomeViewModel()
    
    static func make() -> HomeViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.storyboardId.homeViewController) as! HomeViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        setupNib()
        takeTodoItem()
    }
    
    private func takeTodoItem(){
        homeViewModel.takeTodoItems {
            
            toDoListTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func setUpUi(){
        title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addTodoItem))
    }
    private func setupNib(){
        
        self.toDoListTableView.register(UINib(nibName: "ToDoListTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoListTableViewCell")
    }
    
    @objc func addTodoItem() {
        let viewController = ManageToDoViewController.make()
        viewController.delegate = self
        navigationController?.present(viewController, animated: true)
    }
    
}

// MARK: Table view Data source

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.todoItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.toDoListTableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        let todoItem = homeViewModel.todoItems[indexPath.row]
        cell.configureProductCell(todo: todoItem)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ManageToDoViewController.make()
        viewController.delegate = self
        viewController.todoItem = homeViewModel.todoItems[indexPath.row]
        navigationController?.present(viewController, animated: true)
    }
    
}

extension HomeViewController: ManageToDoViewControllerDelegate {
    func saveTodoItems(message: String) {
        homeViewModel.takeTodoItems {
            toDoListTableView.reloadData()
        }
        alertPresent(title: "", message: message)
    }
    
    
}
