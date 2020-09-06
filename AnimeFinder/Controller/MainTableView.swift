//
//  MainTableView.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/4/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import UIKit

class MainTableView: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //MARK: - ImagePicker
    
    let ImagePicker = UIImagePickerController()

    @IBAction func ImageAdder(_ sender: Any) {
        ImagePicker.allowsEditing = false
        ImagePicker.sourceType = .photoLibrary
        
        present(ImagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "Skadosh")
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        ImagePicker.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    let cum = ["Cum", "Cum", "And more cum"]
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cum.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Skadosh", for: indexPath) as! PhotoCell
        
        
        return cell
    }
    
    
}


//MARK: - Extenions

extension MainTableView {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //            pickedImage.contentMode = .scaleAspectFit
            //            pickedImage.image = pickedImage
            let TheString = convertImageToBase64(pickedImage)
            API(ImageString: TheString)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Image conversion Functions
    
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
}

