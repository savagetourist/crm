import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpResponse,
  HttpErrorResponse
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { PreloaderService } from '../services/preloader/preloader.service';
import { tap } from 'rxjs/operators';

@Injectable()
export class PreloaderInterceptor implements HttpInterceptor {

  constructor(
    private preloaderService : PreloaderService
  ) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {

    this.startRequest();

    return next.handle(request).pipe(tap((event: HttpEvent<any>) => {
      if (event instanceof HttpResponse) {
        this.endRequest();
      }
      // if (event instanceof HttpErrorResponse) {
      //   ///error
      // }
      },
      (err : any) => {
        console.log('Error intercept', err);
        this.endRequest();
      }
    ));
  }
  endRequest() : void {
    this.preloaderService.hidePreloader();
  }
  startRequest() : void {
    this.preloaderService.showPreloader();
  }
}
