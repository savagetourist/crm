import { EventEmitter, Input, Output } from '@angular/core';
import { Component, OnInit } from '@angular/core';
import { Navigation } from 'src/app/models/navigation';

@Component({
  selector: 'app-sidenav-list',
  templateUrl: './sidenav-list.component.html',
  styleUrls: ['./sidenav-list.component.sass']
})
export class SidenavListComponent implements OnInit {


  @Input() navigation : Navigation[];
  @Output() sidenavClose = new EventEmitter();

  constructor() { }

  ngOnInit(): void {
  }

  onSidenavClose() : void {
    this.sidenavClose.emit();
  }

}
