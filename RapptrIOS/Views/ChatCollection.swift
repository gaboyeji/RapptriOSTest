//
//  ChatCollection.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 7/29/22.
//

import UIKit

class ChatCollection: CellCollectionTemplate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    private var messageViewModels: [MessageViewModel] = {
        var mvm: [MessageViewModel] = []
        let filename: String = "messages_test"
        let file_ext: String = "json"
        
        if let url = Bundle.main.url(forResource: filename, withExtension: file_ext) {
            do {
                let data = try Data(contentsOf: url)
                let allMessages = try JSONDecoder().decode(Messages.self, from: data)

                // Uncomment to show messages output in console
                //print("\(allMessages.data)")
                
                // Map Message object to MessageViewModel object
                mvm = allMessages.data.map({return MessageViewModel(message: $0)})

            } catch {
                ConsoleLogger.debug("Local file '\(filename).\(file_ext)' not loaded!")
            }
        }
        
        return mvm
    }()
    
    // MARK: messageCollection
    lazy var messageCollection: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 0
        
        let y: CGFloat = 0
        let h = (SCREEN_SIZE.height - y)
        let w: CGFloat = SCREEN_SIZE.width
        let rect = CGRect(x: 0, y: y, width: w, height: h)
        
        let cv = UICollectionView(frame: rect, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ChatCollectionCell.self, forCellWithReuseIdentifier: ChatCollectionCell.cellIdentifier)
        cv.decelerationRate = .normal
        
        return cv
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messageViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionCell.cellIdentifier, for: indexPath) as! ChatCollectionCell)
        cell.configure(vm: messageViewModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let w = SCREEN_SIZE.width
        //ref: 16+50+7+36+8+8
        let sub: CGFloat = 16+50+7+36+8+8
        let cw = (SCREEN_SIZE.width - (sub))
        let h: CGFloat = messageViewModels[indexPath.item].message.calculateHeight(withConstrainedWidth: cw, font: font_chat_msg) + 13+4+8+8

        return CGSize(width: w, height: h)
    }
    
    func fetchMessages() {
        let chatClient = ChatClient()
        
        chatClient.fetchChatData { mvm, res_duration in
            DispatchQueue.main.async {
                self.messageViewModels = []
                self.messageViewModels = mvm
                self.messageCollection.reloadData()
            }
        } error: { error in
            ConsoleLogger.debug("\n\n\(error!)\n\n")
        }
    }
    
    override func setupViews() {
        addSubview(messageCollection)
        
        // Comment to show inline message entry
        fetchMessages()
    }
    
}


extension UICollectionView {
    var widestCellWidth: CGFloat {
        let insets = contentInset.left + contentInset.right
        return bounds.width - insets
    }
}
