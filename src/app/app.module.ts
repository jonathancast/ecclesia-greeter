import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { SigninComponent } from './signin.component';
import { LoginComponent } from './login.component';
import { MemberComponent } from './member.component';
import { VisitorComponent } from './visitor.component';
import { HeaderComponent } from './header.component';
import { FooterComponent } from './footer.component';
import { ReportsComponent } from './reports.component';

@NgModule({
  declarations: [
    AppComponent,
    SigninComponent,
    LoginComponent,
    MemberComponent,
    VisitorComponent,
    HeaderComponent,
    FooterComponent,
    ReportsComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AppRoutingModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
