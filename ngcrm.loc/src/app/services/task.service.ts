import { Injectable } from '@angular/core';
import { Task } from 'src/app/models/task';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ResponseHttpLead } from '../models/responceHttpLead';
import { ResponseHttpTask } from '../models/ResponseHttpTask';
import { ResponseHttp } from '../models/responseHttp';

@Injectable({
  providedIn: 'root'
})
export class TaskService {

  getArchiveTasks(page: number)  : Observable<Task[]> {
    return this.http.get<ResponseHttp>(environment.apiUrl + 'api/admin/tasks/archive/index'+"?page=" + page).pipe(
      map((data) => {
        return data.data.items;
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
  

  getTasks() : Observable<{
    process : Task[],
    new : Task[],
    done : Task[]
  }> {
    return this.http.get<ResponseHttpTask>(environment.apiUrl + 'api/admin/tasks').pipe(
      map((data) => {
        return data.data.items
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  constructor(private http: HttpClient) {
    
  }


  storeTask(task: Task) : Observable<Task> {
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/tasks', task ).pipe(
      map((data) => {
        return data.data.item
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
}
