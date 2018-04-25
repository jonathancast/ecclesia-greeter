import { Component } from '@angular/core';
import { EventEmitter } from '@angular/core';
import { Output } from '@angular/core';

import { Api } from './api.service';

@Component({
    selector: 'login-page',
    templateUrl: './login.component.html',
    styleUrls: ['./login.component.css'],
    providers: [Api],
})
export class LoginComponent {
    login_id = '';
    password = '';
    error_message = '';
    @Output() logged_in = new EventEmitter();
    constructor(private _api: Api) { }
    login() {
        this.error_message = '';
        this._api.login(this.login_id, this.password).subscribe({
            next: res => { this.logged_in.next(res); },
            error: err => {
                switch(err.code) {
                    case 'invalid_login':
                        this.error_message = "The login id or password you supplied is incorrect";
                        break;
                    default:
                        console.log("Unknown error", err);
                        this.error_message = "Unknown error logging in";
                        break;
                }
            },
        });
    }
}
