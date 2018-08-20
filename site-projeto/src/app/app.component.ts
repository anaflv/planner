import { Component } from '@angular/core';

import { UserData, Course, UfabcClass, ClassList } from './model';
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

  }



  courses: SiteCourse[] = [
      { name: 'Bacharelado em Ciência da Computação', id: 1}
    , { name: 'Engenharia Aeroespacial', id: 2 }
    , { name: 'Engenharia Ambiental', id: 3 }
    , { name: 'Engenharia Biomédica', id: 4 }
    , { name: 'Engenharia de Instrumentação, Automação e Robótica', id: 8 }
    , { name: 'Engenharia de Materiais', id: 9 }
    , { name: 'Neurociência', id: 10 }
    , { name: 'Licenciatura em Biologia', id: 11 }
    , { name: 'Licenciatura em Química', id: 12 }
  ]

  getUrl() {

    console.log("hello");
    this.showConfig();

    console.log(this.userData);

  }

  course: Course;
  classList: ClassList;
  l: UfabcClass[];

  showConfig() {
    this.dataService.getConfig()
      .subscribe((data: Course[]) => this.courses2 = { ...data });
    console.log(this.courses2);
  }


  getClasses(): void {
    this.dataService.getClassList(this.userData as UserData)
      .subscribe(classList => {
        console.log(classList);
        this.classList = classList;
        this.l = classList.obrigatorias;
        console.log(this.l);
      });
  }

}



export class SiteCourse {
  name: string;
  id: number;
}


