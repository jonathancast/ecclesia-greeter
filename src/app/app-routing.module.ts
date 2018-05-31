import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';

import { SigninComponent } from './signin.component';

const appRoutes = [
    { path: '', pathMatch: 'full', component: SigninComponent, },
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
