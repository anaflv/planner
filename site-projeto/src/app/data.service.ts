/* tslint:disable:no-unused-variable */
import { Injectable } from '@angular/core';
import { Headers, Http } from '@angular/http';  // <-- import Http & Headers

import { Customer } from './model';
import { Observable } from 'rxjs';

import { map } from 'rxjs/operators';

@Injectable()
export class DataService {
    private customersUrl = 'localhost:8080/courses';
    private statesUrl = 'api/states';
    private apiUrl = 'localhost:8080/courses';
    private coursesUrl = 'localhost:8080/courses';

    constructor(
        private http: Http) { }


    teste() {
        console.log(this.apiUrl);
    
    }

    

    /** Get existing customers as a Promise */
    getCustomersP(): Promise<Customer[]> {
        //this.logger.log('Getting customers as a Promise via Http ...');

        return this.http.get(this.customersUrl) // <-- returns an observable
            .toPromise()  // <-- convert immediately to a promise
            .then(response => {
                const custs = response.json().data as Customer[]; // <-- extract data from the response
                //this.logger.log(`Got ${custs.length} customers`);
                return custs;
            })
            .catch((error: any) => {
                //this.logger.log(`An error occurred ${error}`); // for demo purposes only
                // re-throw user-facing message
                return Promise.reject('Something bad happened with customers; please check the console');
            });
    }

    /** Get existing customers as a Promise */
    getCourses(): Promise<Customer[]> {
        //this.logger.log('Getting customers as a Promise via Http ...');

        // return this.http.get(this.){

        // }

        return this.http.get(this.customersUrl) // <-- returns an observable
            .toPromise()  // <-- convert immediately to a promise
            .then(response => {
                const custs = response.json().data as Customer[]; // <-- extract data from the response
                //this.logger.log(`Got ${custs.length} customers`);
                return custs;
            })
            .catch((error: any) => {
                //this.logger.log(`An error occurred ${error}`); // for demo purposes only
                // re-throw user-facing message
                return Promise.reject('Something bad happened with customers; please check the console');
            });
    }

    

    /** Get existing customers as an Observable */
    getCustomers(): Observable<Customer[]> {
        //this.logger.log('Getting customers as an Observable via Http ...');

        return this.http.get(this.customersUrl)
            .pipe(map(response => response.json().data as Customer[])
            );
    }

    /** Get existing states as an Observable */
    getStates(): Observable<string[]> {
        //this.logger.log('Getting states as an Observable via Http ...');

        return this.http.get(this.statesUrl)
            .pipe(map(response => {
                return response.json().data as string[];
            }));
    }
}