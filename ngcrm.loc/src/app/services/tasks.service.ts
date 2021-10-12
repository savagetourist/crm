import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { ResponseHttp } from '../models/responseHttp';
import { Task } from '../models/task';

@Injectable({
  providedIn: 'root'
})
export class TasksService {
  storeTask(task: Task) : Observable<Task>{
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/tasks', task).pipe(
      map((data) => {
        return data.data.item
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  constructor(
    private http: HttpClient
  ) { }
}
