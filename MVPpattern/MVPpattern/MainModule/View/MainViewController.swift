//
//  MainViewController1.swift
//  MVPpattern
//
//  Created by Михаил on 10.05.2022.
//

import UIKit

class MainViewController: UIViewController {

    var tableView = UITableView()
    var searchBar = UISearchBar()
        
        
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        configureTableView()
        configureUI()
        setupConstraints()
    }
    
          
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    
    func configureUI(){
        view.addSubview(activityIndicator)
        searchBar.sizeToFit()
        searchBar.barStyle = .black
        navigationItem.titleView = searchBar
        view.backgroundColor = .white
        navigationItem.title = "Comments"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 250/255, green: 255/255, blue: 199/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.scrollEdgeAppearance =  navigationController?.navigationBar.standardAppearance
       
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let movie = presenter.movies?.results[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = movie?.title
        configuration.secondaryText = movie?.resultDescription
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     tableView.deselectRow(at: indexPath, animated: true)
        let movie = presenter.movies?.results[indexPath.row]
        let secondaryViewController = ModuleBuilder.createSecondaryModule(movie: movie)
        navigationController?.pushViewController(secondaryViewController, animated: true)
    }
}


extension MainViewController: MainViewProtocol {
    var searchText: String {
        get {
            searchBar.text ?? ""
        }
        set {
            
        }
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        print(error.localizedDescription)
    }

}


extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let text = searchBar.text else {return}
        presenter.getMoviesData(searchText: text)
        self.activityIndicator.startAnimating()
    }
}
