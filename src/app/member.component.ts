import { Component } from '@angular/core';

import { Api, Member } from './api.service';

@Component({
    selector: 'member',
    templateUrl: './member.component.html',
    styleUrls: ['./member.component.css'],
    providers: [],
})
export class MemberComponent {
    state = 'need_member';
    phone = '';
    member: Member | void = undefined;
    error_message = '';

    constructor(private _api: Api) { }

    checkin() {
        this.error_message = '';
        this._api.member(this.phone).subscribe({
            next: res => {
                if (res === undefined) {
                    this.state = 'need_member';
                    this.error_message = 'Sorry, the phone number ' + this.phone + ' is not in our database';
                } else {
                    this.state = 'have_member';
                    this.member = res;
                }
            },
            error: err => {
                switch (err.code) {
                    case 'nophone':
                        this.state = 'need_member';
                        this.error_message = 'Please enter a phone number';
                        break;
                    case 'badphone':
                        this.state = 'need_member';
                        this.error_message = "Sorry, the phone number you entered is invalid. Please check it and correct any mistakes.";
                        break;
                    default:
                        console.log("Unknown error", err);
                        this.state = 'need_member';
                        this.error_message = "Sorry, couldn't find that member for some reason; guru hint: " + err.code;
                        break;
                }
            },
        });
    }

    change_member() {
        this.error_message = '';
        this.state = 'need_member';
        this.phone = '';
    }
}
