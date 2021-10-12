import { Component, OnInit, ComponentRef } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Task } from 'src/app/models/task';
import { User } from 'src/app/models/user';
import { TaskService } from 'src/app/services/task.service'; 
import { ModalHistoryComponent } from '../childComponents/modal-history/modal-history.component';
import { ModalTaskHistoryComponent } from '../childComponents/modalTask/modal-task-history/modal-task-history.component';
import { ModalTaskComponent } from '../childComponents/modalTask/modal-task/modal-task.component';


@Component({
  selector: 'app-tasks',
  templateUrl: './tasks.component.html',
  styleUrls: ['./tasks.component.sass']
})
export class TasksComponent implements OnInit {

  processingTasks : Array<Task>;
  nTasks : Array<Task>;
  dTasks : Array<Task>;

  user : User;

  constructor(
    private taskService : TaskService,
    private modalService: MatDialog,
  ) { }

  ngOnInit() {
    this.taskService.getTasks().subscribe((data) => {
      this.processingTasks = data.process;
      this.nTasks = data.new;
      this.dTasks = data.done
    });

    this.user = JSON.parse(sessionStorage.getItem('currentUser'));
  }

  public openSourceModal() {
    this.modalService.open(ModalTaskComponent,
      { data : {
          tasks : this.nTasks
      },
        width : '80%'
      });
  }

  public openHistory(event, task : Task, index : number, tasks : Array<Task>) {
    this.modalService.open(ModalTaskHistoryComponent,
                  
                 {data: {
                    nTasks : this.nTasks, 
                    processingTasks : this.processingTasks, 
                    dTasks : this.dTasks, 
                    task : task, 
                    index,
                    tasks : tasks
                  },
                  width: '80%'
                 }  
                  );
  }

}
