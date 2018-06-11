//
//  ViewController.swift
//  TextFieldDemo
//
//  Created by prakash on 21/05/18.
//  Copyright © 2018 prakash. All rights reserved.
//

import UIKit
import PNTextField

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtFullName: PNTextField!
    @IBOutlet weak var txtEmail: PNTextField!
    @IBOutlet weak var txtPassword: PNTextField!
    @IBOutlet weak var txtConfirmPassword: PNTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFullName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        txtFullName.returnKeyType = UIReturnKeyType.next
        txtEmail.returnKeyType = UIReturnKeyType.next
        txtPassword.returnKeyType = UIReturnKeyType.next
        txtConfirmPassword.returnKeyType = UIReturnKeyType.done
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case txtFullName:
            txtEmail.becomeFirstResponder()
        case txtEmail:
            txtPassword.becomeFirstResponder()
        case txtPassword:
            txtConfirmPassword.becomeFirstResponder()
        default:
            txtConfirmPassword.resignFirstResponder()
        }
        
        return true
    }

    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        guard validateData() else { return }
        
        let alert = UIAlertController(title: "Congratulations", message: "Your registration is successful !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (cancel) in
            
            DispatchQueue.main.async {
                self.txtFullName.text = ""
                self.txtEmail.text = ""
                self.txtPassword.text = ""
                self.txtConfirmPassword.text = ""

            }
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func validateData() -> Bool {
        
        guard !txtFullName.text!.isEmptyStr else {
            txtFullName.showError(message: "Full name is required.")
            return false
        }
        
        guard !txtEmail.text!.isEmptyStr else {
            txtEmail.showError(message: "Email is required.")
            return false
        }
        
        guard !txtPassword.text!.isEmptyStr else {
            txtPassword.showError(message: "Password is required.")
            return false
        }
        
        guard !txtConfirmPassword.text!.isEmptyStr else {
            txtConfirmPassword.showError(message: "Confirm password is required.")
            return false
        }
        
        guard txtPassword.text == txtConfirmPassword.text else {
            txtConfirmPassword.showError(message: "Password and Confirm password are not matching.")
            return false
        }
        
        return true
    }
    
}

