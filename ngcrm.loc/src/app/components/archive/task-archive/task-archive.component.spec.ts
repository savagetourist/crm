import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskArchiveComponent } from './task-archive.component';

describe('TaskArchivesComponent', () => {
  let component: TaskArchiveComponent;
  let fixture: ComponentFixture<TaskArchiveComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TaskArchiveComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TaskArchiveComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
