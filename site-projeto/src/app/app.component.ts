import { Component } from '@angular/core';

import { UserData } from './model';
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
  
  title = 'app';

  ngOnInit(){
    this.userData = undefined;
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

  get_url (){
      this.dataService.teste();
  }

}

 


export class Courses {
  name: string;
}
