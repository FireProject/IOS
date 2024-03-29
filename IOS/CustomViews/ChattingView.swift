//
//  ChattingView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/19.
//


import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

/*
 * note : 본인보여주는 셀만 underLine이 있기를 원함
 */
class ChattingView: UIView,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var chattingTable: UITableView!
    weak var navigationController:BurningUpMainViewController?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        guard let view = loadView(nibName: "ChattingView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.chattingTable.delegate = self
        self.chattingTable.dataSource = self
        chattingTable.register(ChattingTableCell.classForCoder(), forCellReuseIdentifier: "chattingCell")
    }
    
    func setNavigation(navigation:BurningUpMainViewController) {
        self.navigationController = navigation
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomDatas.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chattingTable.dequeueReusableCell(withIdentifier: "chattingCell") as! ChattingTableCell
        cell.backgroundColor = .black
        cell.profileImage.image = roomDatas[indexPath.row].image
        cell.roomName.text = roomDatas[indexPath.row].roomName
        cell.lastMessage.text = "testMEssage"
        cell.roomName.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRoom = roomDatas[indexPath.row]
        let storyboard = UIStoryboard(name: "BurningUpMain", bundle: nil)
        let pushController = storyboard.instantiateViewController(withIdentifier: "ChattingViewController")
        pushController.modalPresentationStyle = .fullScreen
        self.navigationController?.navigationController?.pushViewController(pushController, animated: true)
    }
}
