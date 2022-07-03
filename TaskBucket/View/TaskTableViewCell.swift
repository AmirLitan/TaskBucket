//
//  TaskTableViewCell.swift
//  TaskBucket
//
//  Created by amir litan on 03/07/2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskCellUIL: UILabel!
    @IBOutlet weak var networkCellBT: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
