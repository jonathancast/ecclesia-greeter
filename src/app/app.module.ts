import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { LoginComponent } from './login.component';
import { MemberComponent } from './member.component';
import { VisitorComponent } from './visitor.component';
import { FooterComponent } from './footer.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    MemberComponent,
    VisitorComponent,
    FooterComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
