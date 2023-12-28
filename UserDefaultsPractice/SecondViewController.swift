import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    private var usersArray: [[String: Any]] = []
    private var filteredUsers: [[String: Any]] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a user"
        return searchBar
    }()
    // Buttonn getting added
    private let addButton: UIButton = {
            let button = UIButton()
            button.setTitle("Add User", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            // Add a target to handle button tap
            button.addTarget(self, action: #selector(addUserButtonTapped), for: .touchUpInside)
            return button
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Retrieve user details array from UserDefaults
        usersArray = UserDefaults.standard.array(forKey: "usersArray") as? [[String: Any]] ?? []
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        //Configuring Search Bar
        searchBar.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(addButton)
        // Layout constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        
                        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                        
                        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return usersArray.count
        if isSearching {
            return filteredUsers.count
        } else {
            return usersArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Display user name in the cell
//        if let userName = usersArray[indexPath.row]["name"] as? String {
//            cell.textLabel?.text = userName
//        }
        
        let user: [String: Any]
               if isSearching {
                   user = filteredUsers[indexPath.row]
               } else {
                   user = usersArray[indexPath.row]
               }
               
               if let userName = user["name"] as? String {
                   cell.textLabel?.text = userName
               }
        
        return cell
    }
    
    
    // MARK: - UISearchBarDelegate
    private var isSearching: Bool {
            return searchBar.text?.isEmpty == false
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredUsers = usersArray.filter { user in
                if let userName = user["name"] as? String {
                    return userName.lowercased().contains(searchText.lowercased())
                }
                return false
            }
            
            tableView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Handle row selection if needed
        }
    
    @objc private func addUserButtonTapped() {
            
           print ("New User is Getting Printed")
           // Initialize UserDetailsViewController
            let userDetailsViewController = UserDetailsViewController()

            // Load the UserDetailsViewController and call setupUI()
            userDetailsViewController.loadViewIfNeeded()
            userDetailsViewController.setupUI()
           navigationController?.pushViewController(userDetailsViewController, animated: true)
        }
}

