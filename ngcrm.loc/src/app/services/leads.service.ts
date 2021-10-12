import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Analitic } from '../models/analitic';
import { Lead } from '../models/lead';
import { ResponseHttpLead } from '../models/responceHttpLead';
import { ResponseHttp } from '../models/responseHttp';

@Injectable({
  providedIn: 'root'
})
export class LeadsService {

  getAnalitics(dateStart: string, dateEnd: string)  : Observable<Analitic[]> {
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/analitics', {
      dateStart : dateStart,
      dateEnd : dateEnd,
    }).pipe(
      map((data) => {
        return data.data.items;
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  getArchiveLeads(page: number)  : Observable<Lead[]> {
    return this.http.get<ResponseHttp>(environment.apiUrl + 'api/admin/leads/archive/index' + "?page=" + page).pipe(
      map((data) => {
        return data.data.items;
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
  
  addQuality(lead: Lead)  : Observable<Lead> {
    return this.http.put<ResponseHttp>(environment.apiUrl + 'api/admin/leads/update/quality/' + lead.id, lead).pipe(
      map((data) => {
        return data.data.item;
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
  
  getLeads() : Observable<{
    process : Lead[],
    new : Lead[],
    done : Lead[]
  }> {
    return this.http.get<ResponseHttpLead>(environment.apiUrl + 'api/admin/leads').pipe(
      map((data) => {
        return data.data.items
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  storeLead(lead: Lead) : Observable<Lead> {
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/leads', lead).pipe(
      map((data) => {
        return data.data.item
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
  updateLead(lead: Lead) : Observable<Lead> {
    return this.http.put<ResponseHttp>(environment.apiUrl + 'api/admin/leads/'+lead.id, lead).pipe(
      map((data) => {
        return data.data.item
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
  checkLead(lead: Lead) : Observable<{exist:boolean, item : Lead}> {
    return this.http.post<ResponseHttp>(environment.apiUrl + 'api/admin/leads/create/check', lead).pipe(
      map((data) => {
        return {
          exist:data.data.exist, 
          item : data.data.item
        }
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }
  
  addSaleCount() : Observable<number> {
    return this.http.get<ResponseHttp>(environment.apiUrl + 'api/admin/leads/addSale/count').pipe(
      map((data) => {
        return data.data.number
      }),
      catchError((error) => {
        return throwError(error);
      })
    );
  }

  constructor(private http: HttpClient) { }
}
