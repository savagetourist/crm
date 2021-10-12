import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { TaskComment } from 'src/app/models/taskComment';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ResponseHttp } from '../models/responseHttp';
import { HttpClient } from '@angular/common/http';
import { Task } from '../models/task';

@Injectable({
  providedIn: 'root'
})
export class TaskCommentService {
  

  constructor(private http: HttpClient) { }


  getComments(id: number) : Observable<TaskComment[]> {
    return this.http.get<ResponseHttp>(environment.apiUrl + 'api/admin/tasks/history/' + id).pipe(
      map((data) => {
        return data.data.items
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  
  storeTaskComment(task: TaskComment) : Observable<Task> {
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/tasks_comments', task ).pipe(
      map((data) => {
        return data.data.item
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
}
