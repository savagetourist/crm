import { Component, OnInit, Input, Inject } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Lead } from 'src/app/models/lead';
import { Source } from 'src/app/models/source';
import { Status } from 'src/app/models/status';
import { Task } from 'src/app/models/task';
import { TaskComment } from 'src/app/models/taskComment';
import { Unit } from 'src/app/models/unit';
import { User } from 'src/app/models/user';
import { SourcesService } from 'src/app/services/sources.service';
import { StatusService } from 'src/app/services/status.service';
import { TaskCommentService } from 'src/app/services/task-comment.service';
import { TaskService } from 'src/app/services/task.service';
import { UnitsService } from 'src/app/services/units.service';
import { UsersService } from 'src/app/services/users.service';


@Component({
  selector: 'app-modal-task-history',
  templateUrl: './modal-task-history.component.html',
  styleUrls: ['./modal-task-history.component.sass']
})
export class ModalTaskHistoryComponent  implements OnInit  {

  form : FormGroup;
  taskComments: TaskComment[];
  taskComment: TaskComment;
  users : User[];
  statuses : Status[];
  
  
  constructor(
    private taskService : TaskService, 
    private toastService: MatSnackBar,
    private unitsService: UnitsService, 
    private sourcesService : SourcesService, 
    private taskCommentService : TaskCommentService,
    private userService : UsersService,
    private statusService : StatusService,

    private dialogRef: MatDialogRef<ModalTaskHistoryComponent>,
    
    @Inject(MAT_DIALOG_DATA) public data: {
      nTasks : Task[],
      processingTasks : Task[],
      dTasks : Task[],
      task : Task,
      index : number,
      tasks : Task[],
    }
  ) {
      
      this.taskComments = [];
      this.taskComment = new TaskComment();

  }


  // convenience getter for easy access to form fields
  get f() { return this.form.controls; }

  ngOnInit() {

    setTimeout(() => {
      this.getStatuses();
      this.getTaskComments();
      this.getUsers();
    },10);

    this.form = new FormGroup({

      text : new FormControl(""),
      status_id : new FormControl(this.data.task.status_id),
      responsible_id : new FormControl(this.data.task.responsible_id),
      
    });
    
  }
  getTaskComments() {
    this.taskCommentService.getComments(this.data.task.id).subscribe((data: TaskComment[]) => {
      this.taskComments = data;
    });
  }

  getStatuses() {
    this.statusService.getStatuses()
      .subscribe((data: Status[]) =>  {
        this.statuses = data;
      });
  }

  getUsers () {
    this.userService.getUsers()
      .subscribe((data: User[]) =>  {
        this.users = data;
      });
  }

  onSubmit () {

    if (this.form.invalid) {
      return;
    }

    this.taskComment = Object.assign(this.form.value);
    this.taskComment.task_id = this.data.task.id;

    this.storeTaskComment();

    this.dialogRef.close();
    
  }

  storeTaskComment() {

    this.taskCommentService.storeTaskComment(this.taskComment).subscribe((data : Task) => {
      this.toastService.open("Saved","Close", {
        duration: 2000
      });
    
      this.data.tasks.splice(this.data.index, 1); /*вырезаем лид*/
      
      //this.task = data.task;
      if(data.status_id == 1) {
        this.data.nTasks.push(data);
      }
      if(data.status_id == 2) {
        this.data.processingTasks.push(data);
      }
      if(data.status_id == 3) {
        this.data.dTasks.push(data);
      }

    });

  
  }

  

}
