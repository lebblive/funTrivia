//
//  QuestionView.swift
//  FunTrivia
//
//  Created by hackeru on 31/07/2019.
//  Copyright © 2019 kevin vidal. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    @IBOutlet private var label: UILabel!
    
    enum Style{
        case correct, incorrect, standar
    }
    
    var style: Style = .standar{
        didSet{
            setStyle(style )
        }
    }
    
    private func setStyle(_ style: Style){
        switch style{
        case .correct:
            label.backgroundColor = #colorLiteral(red: 0.7798366547, green: 0.9152522683, blue: 0.6264753938, alpha: 1)
            
            break
        case.incorrect:
            label.backgroundColor = #colorLiteral(red: 0.9566981196, green: 0.5398200154, blue: 0.5755229592, alpha: 1)

            break
        case .standar:
            label.backgroundColor = #colorLiteral(red: 0.3546370268, green: 0.5632818341, blue: 0.7849943042, alpha: 1)

            break
        }
    }
    
    var title = ""{
        didSet{
            // when i change my title
            label.text = title 
        }
    }
    
}
