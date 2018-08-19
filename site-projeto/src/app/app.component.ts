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


  userData: UserData = new UserData();
  courses2: Course[];

  title = 'app';

  ngOnInit() {
    // this.userData = new UserData();
    // this.userData.bi = 'hello';


  }



  courses: SiteCourse[] = [
      { name: 'Bacharelado em Ciência da Computação', id: 1}
    , { name: 'Engenharia Aeroespacial', id: 2 }
    , { name: 'Engenharia Ambiental', id: 3 }
    , { name: 'Engenharia Biomédica', id: 4 }
    , { name: 'Engenharia de Energia', id: 5 }
    , { name: 'Engenharia de Gestão', id: 6 }
    , { name: 'Engenharia de Informação', id: 7 }
    , { name: 'Engenharia de Instrumentação, Automação e Robótica', id: 8 }
    , { name: 'Engenharia de Materiais', id: 9 }
  ]

  getUrl() {

    console.log("hello");
    this.showConfig();

    console.log(this.userData);

  }

  course: Course;

  showConfig() {
    this.dataService.getConfig()
      .subscribe((data: Course[]) => this.courses2 = { ...data });


    console.log(this.courses2);


  }


  add(): void {
    this.dataService.addHero(this.userData as UserData)
      .subscribe(hero => {
        console.log('got it');
      });
  }


}



export class SiteCourse {
  name: string;
  id: number;
}


