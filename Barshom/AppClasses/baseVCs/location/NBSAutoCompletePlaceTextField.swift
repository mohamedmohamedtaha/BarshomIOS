//
//  NBSAutoCompletePlaceTextField.swift
//  ArtFood-Trader
//
//  Created by Ahmed Yehia on 07/03/2021.
//


import Foundation
import UIKit
import GooglePlaces
public class NBSAutoCompletePlaceTextField:UITextField {
    /// Manages the instance of tableview
    private var autoCompleteTableView:UITableView?
    /// Holds the collection of attributed strings
    private lazy var attributedAutoCompleteStrings = [NSAttributedString]()
    /// Handles user selection action on autocomplete table view
    public var onSelect:(String, IndexPath)->() = {_,_ in}
    public var onSelectPlaceID:(GMSAutocompletePrediction, IndexPath)->() = {_,_ in}
    /// Handles textfield's textchanged
    public var filter :GMSAutocompleteFilter?
    public var onTextChange:(String)->() = {_ in}
    public var onTextEnd:()->() = {}
    public var autoCompleteStringsPlaceID:[String] = [String]()
    public var autoCompletePlaces:[GMSAutocompletePrediction] = [GMSAutocompletePrediction]()
    /// Font for the text suggestions
    public var autoCompleteTextFont = UIFont.systemFont(ofSize: 12)
    /// Color of the text suggestions
    public var autoCompleteTextColor = UIColor.black
    /// Used to set the height of cell for each suggestions
    public var autoCompleteCellHeight:CGFloat = 40.0
    /// The maximum visible suggestion
    public var maximumAutoCompleteCount = 4
    /// Used to set your own preferred separator inset
    public var autoCompleteSeparatorInset = UIEdgeInsets.zero
    /// Shows autocomplete text with formatting
    public var enableAttributedText = true
    /// User Defined Attributes
    public var autoCompleteAttributes:[NSAttributedString.Key:AnyObject]?
    /// Hides autocomplete tableview after selecting a suggestion
    public var hidesWhenSelected = true
    /// Hides autocomplete tableview when the textfield is empty
    public var hidesWhenEmpty:Bool?{
        didSet{
            assert(hidesWhenEmpty != nil, "hideWhenEmpty cannot be set to nil")
            autoCompleteTableView?.isHidden = hidesWhenEmpty!
        }
    }
    /// The table view height
    public var autoCompleteTableHeight:CGFloat?{
        didSet{
            redrawTable()
        }
    }
    /// The strings to be shown on as suggestions, setting the value of this automatically reload the tableview
    public var autoCompleteStrings:[String] = [String](){
        didSet{ reload() }
    }
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupAutocompleteTable(view: superview!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        setupAutocompleteTable(view: superview!)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        commonInit()
        setupAutocompleteTable(view: newSuperview!)
    }
    
    private func commonInit(){
        hidesWhenEmpty = true
        let attrs = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)] as! [NSAttributedString.Key : Any]

        autoCompleteAttributes = attrs as [NSAttributedString.Key : AnyObject]
        self.clearButtonMode = .always
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    private func setupAutocompleteTable(view:UIView){
        let screenSize = UIScreen.main.bounds.size
        
        let tableView = UITableView(frame: CGRect(x: (self.frame.origin.x / 2) + 10, y: self.frame.origin.y + self.frame.height + 10, width: (self.frame.width), height: 30.0))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.rowHeight = autoCompleteCellHeight
        tableView.isHidden = hidesWhenEmpty ?? true
        view.addSubview(tableView)
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        autoCompleteTableView = tableView
        
        autoCompleteTableHeight = autoCompleteCellHeight * CGFloat(maximumAutoCompleteCount)
    }
    
    private func redrawTable(){
        if let autoCompleteTableView = autoCompleteTableView, let autoCompleteTableHeight = autoCompleteTableHeight {
            var newFrame = autoCompleteTableView.frame
            newFrame.size.height = autoCompleteTableHeight
            autoCompleteTableView.frame = newFrame
        }
    }
    
    //MARK: - Private Methods
    private func reload(){
        if enableAttributedText{
            let attrs = [NSAttributedString.Key.foregroundColor:autoCompleteTextColor, NSAttributedString.Key.font:autoCompleteTextFont]
            
            if attributedAutoCompleteStrings.count > 0 {
                attributedAutoCompleteStrings.removeAll(keepingCapacity: false)
            }
            
            
                for i in 0..<autoCompleteStrings.count{
                    let str = autoCompleteStrings[i] as NSString
                    let range = str.range(of: text!, options: .caseInsensitive)
                    let attString = NSMutableAttributedString(string: autoCompleteStrings[i], attributes: attrs)
                    attString.addAttributes(autoCompleteAttributes!, range: range)
                    attributedAutoCompleteStrings.append(attString)
                }
            
        }
        autoCompleteTableView?.reloadData()
    }
    
    @objc func textFieldDidChange(){
        guard let _ = text else {
            return
        }
        
        onTextChange(text!)
        if text!.isEmpty{
            
            self.autoCompleteStrings.removeAll()
            self.autoCompleteStringsPlaceID.removeAll()
            self.autoCompletePlaces.removeAll()
            self.hidesWhenEmpty = true
            onTextEnd()
        }
        else
        {
        let placesClient = GMSPlacesClient()
        
        placesClient.autocompleteQuery(text!, bounds: nil, filter: filter, callback: { (results, error) in
            
            DispatchQueue.main.async {
                self.autoCompleteStrings.removeAll()
                self.autoCompleteStringsPlaceID.removeAll()
                self.autoCompletePlaces.removeAll()
                if results != nil {
                    for result in results!{
                        self.autoCompletePlaces.append(result)
                        self.autoCompleteStrings.append(result.attributedFullText.string)
                        self.autoCompleteStringsPlaceID.append(result.placeID)
                    }
                }
                if self.autoCompleteStrings.count != 0{
                    self.hidesWhenEmpty = false
                    if self.autoCompleteStrings.count < self.maximumAutoCompleteCount{
                        self.autoCompleteTableHeight = self.autoCompleteTableView?.contentSize.height
                    }else{
                        self.autoCompleteTableHeight = self.autoCompleteCellHeight * CGFloat(self.maximumAutoCompleteCount)
                    }
                    self.autoCompleteTableView?.reloadData()
//                    self.autoCompleteTableView?.makeLoadingAnimations()
                }else{
                    self.hidesWhenEmpty = true
                }
                self.autoCompleteTableView?.isHidden =  self.hidesWhenEmpty!
            }
        })
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) { // in half a second...
            self.autoCompleteTableView?.isHidden =  self.hidesWhenEmpty!
        }
       
    }
    
    @objc func textFieldDidEndEditing() {
        autoCompleteTableView?.isHidden = true
        onTextEnd()
    }
}

//MARK: - UITableViewDataSource - UITableViewDelegate
extension NBSAutoCompletePlaceTextField: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteStrings != nil ? (autoCompleteStrings.count > maximumAutoCompleteCount ? maximumAutoCompleteCount : autoCompleteStrings.count) : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "autocompleteCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if enableAttributedText{
            cell?.textLabel?.attributedText = attributedAutoCompleteStrings[indexPath.row]
        }
        else{
            cell?.textLabel?.font = autoCompleteTextFont
            cell?.textLabel?.textColor = autoCompleteTextColor
            cell?.textLabel?.text = autoCompleteStrings[indexPath.row]
        }
        cell?.backgroundColor = .white
        
        cell?.contentView.gestureRecognizers = nil
        cell?.contentView.tag = indexPath.row
        cell?.textLabel?.isUserInteractionEnabled = false
        let tapMenu: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MenuBtnClicked(_:)))
        cell?.contentView.isUserInteractionEnabled = true
        tapMenu.numberOfTapsRequired = 1
        cell?.contentView.addGestureRecognizer(tapMenu)
        
        return cell!
    }
    @objc func MenuBtnClicked(_ sender : UITapGestureRecognizer) {
        let index = IndexPath(row: sender.view!.tag, section: 0)
        let cell = self.autoCompleteTableView!.cellForRow(at: index )
        
        if let selectedText = cell?.textLabel?.text {
//            self.text = selectedText
            onSelect(selectedText, index)
            onSelectPlaceID(self.autoCompletePlaces[index.row],index)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) { // in half a second...
            self.autoCompleteTableView!.isHidden = true
        }
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let selectedText = cell?.textLabel?.text {
            self.text = selectedText
            onSelect(selectedText, indexPath)
            onSelectPlaceID(self.autoCompletePlaces[indexPath.row],indexPath)

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) { // in half a second...
            tableView.isHidden = self.hidesWhenSelected
        }
    }
   
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)){
            cell.separatorInset = autoCompleteSeparatorInset
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)){
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)){
            cell.layoutMargins = autoCompleteSeparatorInset
        }
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autoCompleteCellHeight

    }
    
}
