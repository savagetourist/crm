import { Source } from "./source";
import { Status } from "./status";
import { Unit } from "./unit";

export class Task {
    id: number;
    link: string;
    phone: string;
    source_id: number;
    unit_id: number;
    user_id: number;
    status_id: number;
    created_at: string;
    source: Source;
    unit: Unit;
    status: Status;
    responsible_id: number;
    lastComment : string;
    author : string;
    responsible : string;
}