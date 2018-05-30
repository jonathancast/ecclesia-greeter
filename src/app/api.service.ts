import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

export interface User {}
export interface SimpleMember {
    id: number;
}
export interface Family {
    members: Array<SimpleMember>;
}
export interface Member {
    id: number;
    family: Family
}
export interface Visitor {
    name: string;
    phone: string;
    email: string;
    address: string;
    address2: string;
    city: string;
    state: string;
    number: number;
    num_children: number;
}

export function empty_visitor() : Visitor {
    return {
        name: undefined,
        phone: undefined,
        email: undefined,
        address: undefined,
        address2: undefined,
        city: undefined,
        state: undefined,
        number: undefined,
        num_children: undefined,
    };
}

@Injectable()
export class Api {
    private _config = undefined;

    constructor(private _http: HttpClient) {}

    get config() {
        return new Observable(observer => {
            if (this._config) {
                observer.next(this._config);
                return observer.complete();
            }
            this._http
                .get('/config')
                .subscribe(_config => {
                    this._config = _config;
                    observer.next(this._config);
                    observer.complete();
                })
            ;
        });
    }

    ping() {
        return new Observable<boolean>(observer => {
            this._http
                .get('/ping')
                .subscribe({
                    next: res => { observer.next(true); observer.complete(); },
                    error: err => {
                        if (err.status == 403) {
                            observer.next(false);
                            observer.complete();
                        } else {
                            observer.error(err);
                        }
                    },
                })
            ;
        });
    }

    login(lid, pwd) {
        return new Observable<User>(observer => {
            this._http
                .post('/login', { login_id: lid, password: pwd, })
                .subscribe({
                    next: res => { observer.next(res); observer.complete(); },
                    error: err => {
                        switch (err.status) {
                            case 403:
                                observer.error(err.error);
                                break;
                            default:
                                console.log("Unknown HTTP response", err);
                                observer.error({ code: 'unknown', });
                                break;
                        }
                    },
                })
            ;
        });
    }

    member(phone) {
        return new Observable<Member>(observer => {
            this._http
                .get('/api/member', { params: { phone: phone, }, })
                .subscribe({
                    next: (res : Member) => { observer.next(res); observer.complete(); },
                    error: err => {
                        switch (err.status) {
                            case 400:
                                observer.error(err.error);
                                break;
                            case 404:
                                observer.next(undefined);
                                observer.complete();
                                break;
                            default:
                                console.log("Unknown HTTP response", err);
                                observer.error({ code: 'unknown', });
                                break;
                        }
                    },
                })
            ;
        });
    }

    checkin(ids) {
        return new Observable(observer => {
            this._http
                .post('/api/checkin', { members: { ids: ids, }, })
                .subscribe({
                    next: res => { observer.next(res); observer.complete(); },
                    error: err => {
                        switch (err.status) {
                            default:
                                console.log("Unknown HTTP response", err);
                                observer.error({ code: 'unknown', });
                                break;
                        }
                    },
                })
            ;
        });
    }

    visitor_signin(visitor) {
        return new Observable(observer => {
            this._http
                .post('/api/visitor/signin', { visitor: visitor, })
                .subscribe({
                    next: res => { observer.next(res); observer.complete(); },
                    error: err => {
                        switch (err.status) {
                            default:
                                console.log("Unknown HTTP response", err);
                                observer.error({ code: 'unknown', });
                                break;
                        }
                    },
                })
            ;
        });
    }
}
