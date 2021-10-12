import { HttpResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ResponseHttp } from 'src/app/models/responseHttp';
import { AuthService } from 'src/app/services/auth/auth.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.sass']
})
export class LoginComponent implements OnInit {


  public loginForm: FormGroup;
  public submitted: boolean = false;
  public loading: boolean = false;
  public returnUrl: string = "form";
  public error : string = "";

  constructor(
    private formBuilder: FormBuilder,
    private authService: AuthService,
    private router : Router,
    private route: ActivatedRoute
  ) { }

  get f() {
    return this.loginForm.controls;
  }

  ngOnInit(): void {
    this.userLogout();
    this.setLoginForm();
  }

  userLogout():void {
    this.authService.logout();
  }

  setLoginForm(): void {
    this.loginForm = this.formBuilder.group({
      email : ['', Validators.required],
      password : ['', Validators.required]
    });
  }

  onSubmit() : boolean {
    this.submitted = true;

    if(this.loginForm.invalid) {
      return false;
    }


    // this.authService.login(this.f.email.value, this.f.password.value)
    this.authService.loginDefault(this.f.email.value, this.f.password.value)
    .pipe(catchError((error: any)=>{
      this.error = (error.error as ResponseHttp).errors.message;
      return throwError(error);
    }))
    .subscribe(data => {
      if(data) {
          this.router.navigate(this.redirectTo())
      }
    });

    return true;
  }
  redirectTo(): any[] {
    
    if(this.route.snapshot.paramMap.get('returnUrl')) {
      return [this.route.snapshot.paramMap.get('returnUrl')];
    }
    return [this.returnUrl];
  }

}
