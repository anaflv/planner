import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatButtonModule, MatCheckboxModule, MatCardModule, MatRadioModule } from '@angular/material';
import  {MatToolbarModule } from '@angular/material/toolbar';
import { HttpClientModule } from '@angular/common/http'; 

 

import { AppComponent } from './app.component';



@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule, 
    MatButtonModule,
    MatCheckboxModule,
    MatToolbarModule,
    MatCardModule,
    MatRadioModule, 
    HttpClientModule
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
