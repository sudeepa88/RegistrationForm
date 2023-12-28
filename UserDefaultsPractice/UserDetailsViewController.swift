

import UIKit

class UserDetailsViewController: UIViewController {

    // MARK: - Properties
    
    var usersArray: [[String: Any]] = []
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number:"
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        return label
    }()
    
    private let genderSegmentedControl: UISegmentedControl = {
        let items = ["Male", "Female", "Other"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //usersArray.removeAll()
        
        if let savedUsersArray = UserDefaults.standard.array(forKey: "usersArray") as? [[String: Any]] {
                   usersArray = savedUsersArray
               }
        
        if !usersArray.isEmpty {
                    // Load SecondViewController
                    let secondViewController = SecondViewController()
                    navigationController?.pushViewController(secondViewController, animated: true)
                } else {
                    // Setup UI for UserDetailsViewController
                    setupUI()
                }
        
       // setupUI()
    }
    
    // MARK: - Private Methods
    
     func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(genderLabel)
        view.addSubview(genderSegmentedControl)
        view.addSubview(saveButton)
        
        // Layout constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            genderLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            genderSegmentedControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func saveButtonTapped() {
        print("Save button tapped")
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
                    // Handle invalid input
                   // add function
                   displayWarning(message: "Please fill all the details")
                    return
                }
                
                // Get the selected gender
                let genderIndex = genderSegmentedControl.selectedSegmentIndex
                let gender: String
                switch genderIndex {
                case 0: gender = "Male"
                case 1: gender = "Female"
                case 2: gender = "Other"
                default: gender = ""
                }
                
                // Create a dictionary to store user details
                let userDetails: [String: Any] = [
                    "name": name,
                    "phoneNumber": phoneNumber,
                    "gender": gender
                ]
                 // Main Part
                 usersArray = UserDefaults.standard.array(forKey: "usersArray") as? [[String: Any]] ?? []
                //usersArray.append(userDetails)
                usersArray.insert(userDetails, at: 0)
                //UserDefaults.standard.set(userDetails, forKey: "userDetails")
                 // usersArray.removeAll()
                // Store the updated array in UserDefaults
                UserDefaults.standard.set(usersArray, forKey: "usersArray")
                UserDefaults.standard.synchronize()
                for user in usersArray {
                 print(user)
                   }
                print("User details saved in UserDefaults")
                let secondViewController = SecondViewController()
                navigationController?.pushViewController(secondViewController, animated: true)
    }
    // displayWarning function
    private func displayWarning(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = .red
        present(alert, animated: true, completion: nil)
    }
}

