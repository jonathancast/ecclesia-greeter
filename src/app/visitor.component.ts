import { Component } from '@angular/core';

import { Api, Visitor, empty_visitor } from './api.service';

@Component({
    selector: 'visitor',
    templateUrl: './visitor.component.html',
    styleUrls: ['./visitor.component.css'],
    providers: [],
})
export class VisitorComponent {
    visitor : Visitor = empty_visitor();
    error_message = '';

    constructor(private _api: Api) { }

    checkin() {
        this.error_message = '';
        if (this.visitor.name == undefined || this.visitor.name == '') {
            this.error_message += 'Please tell us your name. ';
        }
        if (this.visitor.number == undefined || this.visitor.number <= 0) {
            this.error_message += 'Please tell us how many people are in your party (total). ';
        }
        if (this.visitor.num_children == undefined || this.visitor.num_children < 0) {
            this.error_message += 'Please tell us how many children (under 18) are in your party. ';
        }
        if (this.error_message != '') {
            return;
        }

        this._api.visitor_signin(this.visitor).subscribe({
            next: res => this.change_visitor(),
            error: err => {
                switch (err.code) {
                    default:
                        console.log("Unknown error", err);
                        this.error_message = "Sorry, couldn't check in for some reason; guru hint: " + err.code;
                        break;
                }
            },
        });
    }

    change_visitor() {
        this.visitor = empty_visitor();
        this.error_message = '';
    }
}
