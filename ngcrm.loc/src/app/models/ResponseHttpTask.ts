import { Task } from "./task";


export interface ResponseHttpTask {
    status: boolean,
    errors: {
        message? : string
    },
    data: {
        items: {
            process : Task[],
            new : Task[],
            done : Task[]
        }
    }
    
}