//
//  firstViewController.swift
//  Prototype_For_Tokerism
//
//  Created by Ian CHAN on 20/12/2023.
//

import UIKit

class firstViewController: UIViewController {
    
    var text: String?
    
    var curretWord = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        translator()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imageView4: UIImageView!
    @IBOutlet var imageView5: UIImageView!
    @IBOutlet var imageView6: UIImageView!
    
    @IBAction func forward(_ sender: UIButton) {
//        print(text!)
        curretWord += 1
        if curretWord >= text!.count {
            curretWord = text!.count - 1
        }
        translator()
//        print(curretWord)
    }
    
    @IBAction func backward(_ sender: UIButton){
        curretWord -= 1
        if curretWord < 0 {
            curretWord = 0
        }
        translator()
    }
    
    func translator(){
        let text = text!.replacingOccurrences(of: "and", with: "&")
        
        let NoCapchar = Array(text)[curretWord]
        let char = Array(text.lowercased())[curretWord]
        
        let special = Array(text.uppercased())[curretWord]
        
        let letterSetA = ["a", "b", "c", "d", "e", "f", "g", "h", "k", "l", "m", "n", "o", "p", "q", "r", "u", "v", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", ">", "(", "√", "&"]
        
        let letterSetB = ["c", "d", "f", "g", "i", "j", "m", "n", "p", "q", "s", "t", "w", "x", "y", "3", "4", "6", "7", "9", "0", "<", ")", "/", "#", "@", "&"]
        
        let letterSetC = ["b", "f", "g", "h", "i", "j", "l", "p", "q", "r", "s", "t", "v", "w", "2", "6", "7", "8", "9", "0", "+", "-", ":", "=", "<", "(", ".", ",", "!", "?", ";", "&"]
        
        let letterSetD = ["d", "e", "g", "h", "j", "n", "o", "q", "r", "t", "w", "y", "z", "4", "5", "7", "8", "0", ".", "!", ":", ">", ")"]
        
        let letterSetE = ["k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z", "?", "!", ";", "/", ">", ")", "&"]
        
        let letterSetF = ["u", "v", "w", "x", "y", "z", ".", "?", "<", "(", "&"]
        
        if letterSetA.contains(where: {char.description.contains($0)}){
            imageView1.image = UIImage(named: "Filled")
        } else {
            imageView1.image = UIImage(named: "Unfilled")
        }
        
        
        if letterSetB.contains(where: {char.description.contains($0)}){
            imageView2.image = UIImage(named: "Filled")
        } else {
            imageView2.image = UIImage(named: "Unfilled")
        }
        
        if letterSetC.contains(where: {char.description.contains($0)}){
            imageView3.image = UIImage(named: "Filled")
        } else {
            imageView3.image = UIImage(named: "Unfilled")
        }
        
        if letterSetD.contains(where: {char.description.contains($0)}){
            imageView4.image = UIImage(named: "Filled")
        } else {
            imageView4.image = UIImage(named: "Unfilled")
        }
        
        if letterSetE.contains(where: {char.description.contains($0)}){
            imageView5.image = UIImage(named: "Filled")
        } else {
            imageView5.image = UIImage(named: "Unfilled")
        }
        
        if letterSetF.contains(where: {char.description.contains($0)}){
            imageView6.image = UIImage(named: "Filled")
        } else {
            imageView6.image = UIImage(named: "Unfilled")
        }
        
        if(NoCapchar != char){
            imageView6.image = UIImage(named: "Filled")
        } else if (special == char){
            return
        }

        print(char)
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
extension String {
    func contains(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
}
