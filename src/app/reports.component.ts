import { Component } from '@angular/core';

import { Api } from './api.service';

@Component({
    selector: 'reports',
    templateUrl: './reports.component.html',
    styleUrls: ['./reports.component.css']
})
export class ReportsComponent {
    error_message = '';
    state = 'unloaded';
    date = undefined;
    dates = [];
    data = undefined;

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

    reload_report() {
        if (this.date == undefined) {
            this.error_message = 'Please select a date first';
            return;
        }
        this._api.attendance(this.date).subscribe({
            next: res => { this.data = res; console.log(this.data); },
            error: err => {
                switch (err.code) {
                    default:
                        console.log("Unknown error", err);
                        this.error_message = "Couldn't load report for some reason; guru hint: " + err.code;
                        break;
                }
            },
        });
    }
}
