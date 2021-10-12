import { Component, OnInit, Input, Inject } from '@angular/core';

import { FormGroup, FormControl } from '@angular/forms';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Task } from 'src/app/models/task';
import { TaskComment } from 'src/app/models/taskComment';
import { TaskCommentService } from 'src/app/services/task-comment.service';
import { TaskService } from 'src/app/services/task.service';

@Component({
  selector: 'app-modal-archive-task-history',
  templateUrl: './modal-archive-task-history.component.html',
  styleUrls: ['./modal-archive-task-history.component.sass']
})
export class ModalArchiveTaskHistoryComponent  implements OnInit {

  constructor(
    private taskCommentService : TaskCommentService, 
    @Inject(MAT_DIALOG_DATA) public data : {
      task : Task
    }
  ) {

    this.taskComments = [];
   
  }

  form : FormGroup;
  taskComments: Array<TaskComment>;

  // convenience getter for easy access to form fields
  get f() { return this.form.controls; }

  getTaskComments() {
    this.taskCommentService.getComments(this.data.task.id).subscribe((data: TaskComment[]) =>  {
      this.taskComments = data;
    });
  }

  ngOnInit() {
    
    setTimeout(() => {
      this.getTaskComments();
    },10);

    
  }

}
