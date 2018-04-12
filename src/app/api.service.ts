import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';

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
}
