import { LightningElement, api, wire } from 'lwc';
/* Wire adapter to fetch record data */
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import TOTAL_CONTACTS_FIELD from '@salesforce/schema/Account.Total_Contacts__c';

export default class DisplayTotalContacts extends LightningElement {
    @api recordId;

    /* Load Account.Total Contacts for custom rendering */
    @wire(getRecord, {
        recordId: '$recordId',
        fields: [TOTAL_CONTACTS_FIELD]
    })
    record;
 
    /** Gets the Account.Total Contacts value. */
    get totalContactsValue() {
        return this.record.data ? getFieldValue(this.record.data, TOTAL_CONTACTS_FIELD) : '';
    }
}