import { LightningElement } from 'lwc';
export default class WelcomeGreeting extends LightningElement {
    welcomeMsg = 'Hello ... ';
    
    connectedCallback() {
        var currentDate = new Date();
        var currentHour = currentDate.getHours();
        var currentDay = currentDate.getDay();

        if (currentHour >= 4 && currentHour < 12)
            this.welcomeMsg += 'Good Morning. ';
        else if (currentHour >= 12 && currentHour < 17)        
            this.welcomeMsg += 'Good Afternoon. ';
        else //(currentHour >= 17 || currentHour < 4)
            this.welcomeMsg += 'Good Evening. ';

        if (currentDay > 0 && currentDay < 6)
            this.welcomeMsg += 'Have a great day !';
        else
            this.welcomeMsg += 'Have a great weekend !!!';
    }
}