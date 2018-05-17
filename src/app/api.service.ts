import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';

export interface User {}
export interface Member {}

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
        return new Observable<Member|void>(observer => {
            this._http
                .get('/api/member', { params: { phone: phone, }, })
                .subscribe({
                    next: res => { observer.next(res); observer.complete(); },
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
}
