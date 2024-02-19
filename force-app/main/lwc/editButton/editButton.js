import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EditButton extends LightningElement {
    @api recordId;
    @api objectApiName;

    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Record updated successfully',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
        this.closeForm();
    }

    handleCancel() {
        const toastEvent = new ShowToastEvent({
            title: 'Info',
            message: 'Edit operation cancelled',
            variant: 'info',
        });
        this.dispatchEvent(toastEvent);
        this.closeForm();
    }

    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    closeForm() {
        const closeEvent = new CustomEvent('close');
        this.dispatchEvent(closeEvent);
    }
}