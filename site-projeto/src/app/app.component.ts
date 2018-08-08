import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';

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

}

export class Courses {
  name: string;
}
