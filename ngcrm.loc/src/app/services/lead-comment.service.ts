import { HttpClient } from '@angular/common/http';
import { leadingComment } from '@angular/compiler';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Lead } from '../models/lead';
import { LeadComment } from '../models/leadComment';
import { ResponseHttp } from '../models/responseHttp';
import { Status } from '../models/status';

@Injectable({
  providedIn: 'root'
})
export class LeadCommentService {
  
  
  storeLeadComment(leadComment: LeadComment) : Observable<Lead> {
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/lead-comments', leadComment).pipe(
      map((data) => {
        return data.data.item
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  

  getComments(id: number) : Observable<LeadComment[]> {
    return this.http.get<ResponseHttp>(environment.apiUrl + 'api/admin/leads/history/' + id).pipe(
      map((data) => {
        return data.data.items
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  
  constructor(private http: HttpClient) { }
}
