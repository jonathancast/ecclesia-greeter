import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';

import { SigninComponent } from './signin.component';
import { ReportsComponent } from './reports.component';

const appRoutes = [
    { path: '', pathMatch: 'full', component: SigninComponent, },
    { path: 'reports', pathMatch: 'full', component: ReportsComponent, },
];

@NgModule({
    imports: [
        RouterModule.forRoot(appRoutes, { enableTracing: true }),
    ],
    exports: [
        RouterModule,
    ],
})
export class AppRoutingModule { }
