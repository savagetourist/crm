import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AnaliticsComponent } from './components/analitics/analitics.component';
import { LeadArchiveComponent } from './components/archive/lead/lead-archive/lead-archive.component';
import { TaskArchiveComponent } from './components/archive/task-archive/task-archive.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { FormComponent } from './components/form/form.component';
import { LoginComponent } from './components/login/login.component';
import { SourcesComponent } from './components/sources/sources.component';
import { TasksComponent } from './components/tasks/tasks.component';
import { AuthGuard } from './guards/auth.guard';

const routes: Routes = [

  {
    path: '',
    component: DashboardComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'form',
    component: FormComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'login',
    component: LoginComponent,
  },
  {
    path: 'archives',
    component: LeadArchiveComponent,
    canActivate: [AuthGuard]
  },
  {
    path: 'analitics',
    component: AnaliticsComponent,
    canActivate: [AuthGuard]
  },
  {
    path:'tasks',
    component: TasksComponent,
    canActivate: [AuthGuard]
  },
  {
    path:'task_archives',
    component: TaskArchiveComponent,
    canActivate: [AuthGuard]
  },
  {
    path:'sources',
    component: SourcesComponent,
    canActivate: [AuthGuard]
  },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
