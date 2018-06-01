import { Component } from '@angular/core';

import { Api } from './api.service';

@Component({
    selector: 'reports',
    templateUrl: './reports.component.html',
    styleUrls: ['./reports.component.css']
})
export class ReportsComponent {
    error_message = '';
    date = undefined;
    dates = [];

    constructor(private _api: Api) {
        this._api.attendance_dates.subscribe({
            next: res => this.dates = res,
            error: err => {
                switch (err.code) {
                    default:
                        console.log("Unknown error", err);
                        this.error_message = "Couldn't load list of dates for some reason; guru hint: " + err.code;
                        break;
                }
            },
        });
    }
}
