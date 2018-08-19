import { Component } from '@angular/core';

import { UserData, Course } from './model';
import { DataService } from './data.service';



@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  providers: [DataService]
})
export class AppComponent {

  constructor(
    private dataService: DataService) { }


  userData: UserData;
  courses2: Course[];

  title = 'app';

  ngOnInit() {
    // this.userData = new UserData();
    // this.userData.bi = 'hello';


  }



  courses: Courses[] = [
    { name: 'Engenharias' }
    , { name: 'Engenharia Aeroespacial' }
    , { name: 'Engenharia Ambiental' }
    , { name: 'Engenharia Biomédica' }
    , { name: 'Engenharia de Energia' }
    , { name: 'Engenharia de Gestão' }
    , { name: 'Engenharia de Informação' }
    , { name: 'Engenharia de Instrumentação, Automação e Robótica' }
    , { name: 'Engenharia de Materiais' }
  ]

  get_url() {

    console.log("hello");

    this.showConfig();

  }

  course: Course;

  showConfig() {
    this.dataService.getConfig()
      .subscribe((data: Course[]) => this.courses2 = { ...data });


    console.log(this.courses2);


  }



  onClickMe() {
    this.showConfig();

  }


}



export class Courses {
  name: string;
}


