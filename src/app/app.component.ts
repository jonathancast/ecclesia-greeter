import { Component } from '@angular/core';
import { Api } from './api.service';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css'],
    providers: [Api],
})
export class AppComponent {
    logged_in = false;
    constructor(private _api: Api) { }
    ngOnInit(): void {
        this._api.ping().subscribe(res => { this.logged_in = res; });
    }

    onLoggedIn(user) { this.logged_in = true; }
}
