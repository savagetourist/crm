import { Component, OnInit } from '@angular/core';
import { Analitic } from 'src/app/models/analitic';
import { LeadsService } from 'src/app/services/leads.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-analitics',
  templateUrl: './analitics.component.html',
  styleUrls: ['./analitics.component.sass']
})
export class AnaliticsComponent implements OnInit {

  constructor(
    private LeadService : LeadsService
  ) { }

  dateStart : Date;
  dateEnd : Date;

  analiticsData : Analitic[];

  path : string = environment.apiUrl;

  ngOnInit(): void {

    this.dateStart = new Date(new Date().getFullYear(), new Date().getMonth(), 1);
    this.dateEnd = new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0);

    this.getAnalitics();
  }
  getAnalitics() {
    this.LeadService.getAnalitics(this.dateHelper(this.dateStart), this.dateHelper(this.dateEnd)).subscribe((data : Analitic[]) =>{
      this.analiticsData = data;
    });
  }
  dateHelper(date: Date): string {
    /// d.m.Y
    if (date) {
      return date.getDate() + '.' + (date.getMonth() + 1) + '.' + date.getFullYear();
    }
    return '';
  }

}
