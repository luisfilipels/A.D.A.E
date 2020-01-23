//
//  EditLectureViewController.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 23/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import UIKit

class EditLectureViewController: UIViewController {
    @IBOutlet weak var pageTitle: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageTitle.topItem?.title = self.title
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditLectureViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // let disciplinaSelecionada: Disciplina = disciplinas[indexPath.row]
            self.performSegue(withIdentifier: "editLectureSegue", sender: "Matéria")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Nome e horário" : "Dias para repetir"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView
            } else {
                
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SetReminderCell", for: indexPath) as! ReminderTableViewCell

            return cell
        }

    }*/
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function)
    }
    
    
}
