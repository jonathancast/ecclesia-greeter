import { Component } from '@angular/core';
import { Api } from './api.service';

@Component({
    selector: 'header',
    templateUrl: './header.component.html',
    styleUrls: ['./header.component.css'],
    providers: [Api],
})
export class HeaderComponent {
    title = 'Caleo Greeter';
    constructor(private _api: Api) { }
    ngOnInit(): void {
        this._api.config.subscribe((config: any) => { this.title = config['name'] + ' Greeter'; });
    }
}
