import { Pipe, PipeTransform } from '@angular/core';
import { Lead } from '../models/lead';

@Pipe({
  name: 'done'
})
export class DonePipe implements PipeTransform {

  transform(dLeads: Lead[], dleadQuality: boolean, dleadQualityFalse: boolean): Lead[] {
    
    if (dLeads && dLeads.length === 0) {
      return dLeads;
    }

    if (dleadQuality) {
      return dLeads.filter((lead) => lead.isQualityLead == dleadQuality);
    }

    if (dleadQualityFalse) {
      return dLeads.filter((lead) => lead.isQualityLead != dleadQualityFalse);
    }

    return dLeads;
  }

}
