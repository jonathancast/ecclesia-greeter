import { Component } from '@angular/core';
import { Api } from './api.service';

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css'],
    providers: [Api],
})
export class AppComponent {
    title = 'Ecclesia Greeter';
    logged_in = false;
    constructor(private _api: Api) { }
    ngOnInit(): void {
        this._api.config.subscribe((config: any) => { this.title = config['name'] + ' Greeter'; });
        this._api.ping().subscribe(res => { this.logged_in = res; });
    }

    onLoggedIn(user) { this.logged_in = true; }
}
