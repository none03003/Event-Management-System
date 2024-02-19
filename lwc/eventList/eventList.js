import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getEvents from '@salesforce/apex/EventController.getEvents';

const columns = [
    { label: 'Event Name', fieldName: 'Name', type: 'text' },
    { label: 'Start Time', fieldName: 'Date_and_Time__c', type: 'text' },
    { label: 'End Time', fieldName: 'End_Time__c', type: 'text' },
    { label: 'Location', fieldName: 'Location__c', type: 'text' },
    { label: 'Status', fieldName: 'Status__c', type: 'text' },
];

export default class EventList extends NavigationMixin(LightningElement) {
    columns = columns;
    events;

    @wire(getEvents)
    wiredEvents({ error, data }) {
        if (data) {
            this.events = data.map(event => ({
                ...event,
                Name: event.Name,
                Date_and_Time__c: this.formatDateTime(event.Date_and_Time__c),
                End_Time__c: this.formatDateTime(event.End_Time__c),
                Location__c: event.Location__c,
                Status__c: event.Status__c
            }));
        } else if (error) {
            console.error('Error loading event data', error);
        }
    }
    formatDateTime(dateTimeString) {
        const options = { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: false };
        return new Intl.DateTimeFormat('en-US', options).format(new Date(dateTimeString));
    }
    handleRowAction(event) {
        const row = event.detail.row;
        console.log('Row Clicked:', row);

        // Navigate to the event detail page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: 'Event_Manage__c',
                actionName: 'view'
            }
        });
    }
}