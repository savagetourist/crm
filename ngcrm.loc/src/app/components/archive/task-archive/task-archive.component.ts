import { Component, OnInit, ComponentRef } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Task } from 'src/app/models/task';
import { TaskService } from 'src/app/services/task.service';
import { ModalArchiveTaskHistoryComponent } from '../../childComponents/modal-archive-task-history/modal-archive-task-history.component';


@Component({
  selector: 'app-task-archives',
  templateUrl: './task-archive.component.html',
  styleUrls: ['./task-archive.component.sass']
})
export class TaskArchiveComponent implements OnInit {

  page : number;
  tasks : Array<Task>;

  

  constructor(
    private taskService : TaskService, 
    private modalService: MatDialog,
    ) {
    this.page = 1;
    this.tasks  = [];
  }


  ngOnInit() {
    this.getTasks();
  }
  getTasks() {
    this.taskService.getArchiveTasks(this.page).subscribe((data: Task[]) => {
      let taskT : Array<Task> = this.tasks;
      
      data.forEach(function(item) {
          taskT.push(item)
      });
    });
  }

  public loadTask() {
    ++this.page;
    this.getTasks();
  }

  public openHistory(event, task : Task, index : number, tasks : Array<Task>) {

    this.modalService.open(ModalArchiveTaskHistoryComponent, {
      data : {
        task : task,
      },
      width : '80%'
    });

  }

}
