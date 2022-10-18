//
//  CustomSegmentedControl.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 22/02/1444 AH.
//
import UIKit

class CustomSegmentedControl: UIView {
    
    let theme: AppTheme = NewsAppTheme()
    
    private var buttonTitles: [String]!
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    public var _selectedIndex: Int = 0
    
    var titleColor: UIColor = .gray
    var selectorViewColor:UIColor = .orange
    var selectorTextColor:UIColor = .orange
    var indexChangedClosure: ((Int)->())?
    
    
    convenience init(frame: CGRect,
                     buttonTitles: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles: [String]){
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    private func updateView() {
        setUpButtons()
        setUpSelectorView()
        setUpStackView()
    }
    
    private func setUpStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    private func setUpSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: self.frame.height,
                                            width: selectorWidth,
                                            height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func setUpButtons(){
        
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.addTarget(self,
                             action: #selector(CustomSegmentedControl.buttonTapped(sender:)),
                             for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        for (buttonIndex, currentButton) in buttons.enumerated() {
            if currentButton == sender {
                setIndex(index:buttonIndex)
            }
        }
    }
    
    func setIndex(index buttonIndex: Int) {
        
        buttons.forEach({$0.setTitleColor(titleColor, for: .normal)})
        
        let currentButton = buttons[buttonIndex]
        _selectedIndex = buttonIndex
        currentButton.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width / CGFloat(self.buttonTitles.count) * CGFloat(buttonIndex)
        
        indexChangedClosure?(buttonIndex)
        
        UIView.animate(withDuration: 0.3){
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
}
