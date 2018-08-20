/* tslint:disable:no-unused-variable */
import { Injectable } from '@angular/core';

import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable, of } from 'rxjs';
import { Course, UserData, UfabcClass, ClassList } from './model';



import { catchError, map, tap } from 'rxjs/operators';

const httpOptions = {
    headers: new HttpHeaders({ 'Content-Type': 'text/plain' })
  };


@Injectable()
export class DataService {

    constructor(

        private http: HttpClient) { }

    private customersUrl = 'localhost:8080/courses';
    private statesUrl = 'api/states';
    private apiUrl = 'https://ufabc-courses.herokuapp.com/courses';
    private local = 'http://localhost:8080/courses';
    private bin = 'https://httpbin.org/post?foo=12&bar=hello&s=c';



    teste() {


        console.log("hello");
        console.log(this.local);
        //console.log(this.http.get(this.local));


    }

    getConfig() {
        console.log(this.http.get(this.local).pipe);
        return this.http.get<Course[]>(this.local);
    }


    
    getClassList (userdata: UserData): Observable<ClassList> {
        console.log(userdata);
        return this.http.post(`${this.local}`,userdata,httpOptions).pipe(
          tap((model: ClassList) => console.log(model))
        );
      }


    addHero (userdata: UserData): Observable<UserData> {
        //console.log(userdata);
        return this.http.post(`${this.apiUrl}`,userdata,httpOptions).pipe(
          tap((userdata: UserData) => console.log(`added hero w/ id=${userdata.bi}`))
        );
      }


    // t1() {
    //     this.http.get('people.json')
    //       // Call map on the response observable to get the parsed people object
    //       .pipe(map(res => res.json()))
    //       // Subscribe to the observable to get the parsed people object and attach it to the
    //       // component
    //       .subscribe(people => this.people = people);
    //   }




    // /** Get existing customers as a Promise */
    // getCustomersP(): Promise<Customer[]> {


    //     return this.http.get(this.customersUrl) // <-- returns an observable
    //         .toPromise()  // <-- convert immediately to a promise
    //         .then(response => {
    //             const custs = response.json().data as Customer[]; // <-- extract data from the response
    //             //this.logger.log(`Got ${custs.length} customers`);
    //             return custs;
    //         })
    //         .catch((error: any) => {
    //             //this.logger.log(`An error occurred ${error}`); // for demo purposes only
    //             // re-throw user-facing message
    //             return Promise.reject('Something bad happened with customers; please check the console');
    //         });
    // }

    // /** Get existing customers as a Promise */
    // getCourses(): Promise<Customer[]> {
    //     //this.logger.log('Getting customers as a Promise via Http ...');

    //     // return this.http.get(this.){

    //     // }

    //     return this.http.get(this.customersUrl) // <-- returns an observable
    //         .toPromise()  // <-- convert immediately to a promise
    //         .then(response => {
    //             const custs = response.json().data as Customer[]; // <-- extract data from the response
    //             //this.logger.log(`Got ${custs.length} customers`);
    //             return custs;
    //         })
    //         .catch((error: any) => {
    //             //this.logger.log(`An error occurred ${error}`); // for demo purposes only
    //             // re-throw user-facing message
    //             return Promise.reject('Something bad happened with customers; please check the console');
    //         });
    // }



    // /** Get existing customers as an Observable */
    // getCustomers(): Observable<Customer[]> {
    //     //this.logger.log('Getting customers as an Observable via Http ...');

    //     return this.http.get(this.customersUrl)
    //         .pipe(map(response => response.json().data as Customer[])
    //         );
    // }

    // /** Get existing states as an Observable */
    // getStates(): Observable<string[]> {
    //     //this.logger.log('Getting states as an Observable via Http ...');

    //     return this.http.get(this.statesUrl)
    //         .pipe(map(response => {
    //             return response.json().data as string[];
    //         }));
    // }
}